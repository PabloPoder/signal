import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/features/anomalies/models/anomaly.dart';
import 'package:signal/features/anomalies/models/anomaly_rules/ianomaly_rule.dart';
import 'package:signal/features/anomalies/models/anomaly_rules/ioutcome_rule.dart';
import 'package:signal/features/anomalies/providers/anomaly_provider.dart';
import 'package:signal/features/anomalies/services/anomaly_engine.dart';
import 'package:signal/features/anomalies/services/outcome_executor.dart';
import 'package:signal/features/anomalies/services/outcome_generator.dart';
import 'package:signal/features/entry/models/annotation/annotation.dart';
import 'package:signal/features/anomaly_outcomes/models/corruption_profile.dart';
import 'package:signal/features/entry/models/entry.dart';
import 'package:signal/features/entry/models/repositories/entry_repository.dart';
import 'package:signal/features/entry/models/repositories/in_memory_entry_repository.dart';
import 'package:signal/features/entry/providers/anomaly_engine_provider.dart';
import 'package:signal/features/entry/utils/annotation_parser.dart';

final entryRepositoryProvider = Provider<EntryRepository>((ref) {
  return InMemoryEntryRepository();
});

final entryProvider = NotifierProvider<EntryNotifier, List<Entry>>(
  EntryNotifier.new,
);

class EntryNotifier extends Notifier<List<Entry>> {
  /// ---------------------
  /// DEPENDENCIES
  /// ---------------------
  late final EntryRepository _repository;

  /// Domain services
  late final AnomalyEngine anomalyEngine;
  final SignalOutcomeExecutor outcomeExecutor = SignalOutcomeExecutor();

  /// ---------------------
  /// Lifecycle
  /// ---------------------
  @override
  List<Entry> build() {
    _repository = ref.read(entryRepositoryProvider);
    anomalyEngine = ref.read(anomalyEngineProvider);

    return _repository.getAll();
  }

  void _refreshState() {
    state = [..._repository.getAll()];
  }

  /// ---------------------
  /// Queries
  /// ---------------------
  List<Entry> getEntries() => state;

  Entry? findEntry(String id) {
    try {
      return state.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  /// ---------------------
  /// PUBLIC API (CRUD)
  /// ---------------------

  /// Creates an entry initiated by the user.
  /// User-generated entries participate in the anomaly pipeline.
  Entry createEntry({
    required String title,
    required String content,
    CorruptionProfile? corruption,
  }) {
    final entry = _insertEntry(
      title: title,
      content: content,
      corruption: corruption,
    );
    _evaluateAnomalies();

    return entry;
  }

  void deleteEntry(String id) {
    _repository.remove(id);
    _refreshState();
  }

  void updateEntry(Entry entry) {
    _repository.update(entry);
    _refreshState();
  }

  Entry? addAnnotation(
    String entryId,
    String note, {
    AnnotationSource source = AnnotationSource.user,
  }) {
    final entry = findEntry(entryId);

    if (entry == null) return null;

    final annotation = Annotation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      content: source == AnnotationSource.user
          ? normalizeAnnotation(note)
          : note,
      source: source,
    );

    final updatedEntry = entry.copyWith(
      annotations: [...entry.annotations, annotation],
    );

    updateEntry(updatedEntry);

    return updatedEntry;
  }

  /// ---------------------
  /// DOMAIN OPERATIONS
  /// ---------------------

  /// Inserts an entry into the repository without triggering
  /// anomaly evaluation. Used internally by outcome executions.
  Entry _insertEntry({
    required String title,
    required String content,
    CorruptionProfile? corruption,
  }) {
    final entry = Entry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      rawContent: content,
      annotations: const [],
      createdAt: DateTime.now(),
      recoverability: 100,
      corruption: corruption ?? CorruptionProfile(),
    );

    _repository.add(entry);
    _refreshState();

    return entry;
  }

  void _incrementOverwriteCount(String entryId) {
    final entry = findEntry(entryId);

    if (entry == null) return;

    updateEntry(entry.copyWith(overwriteCount: entry.overwriteCount + 1));
  }

  void _applyCorruption(String entryId, CorruptionProfile corruption) {
    final entry = findEntry(entryId);

    if (entry == null) return;

    final merged = entry.corruption.merge(corruption);

    updateEntry(entry.copyWith(corruption: merged));
  }

  ///-------------------
  /// SIGNAL PIPELINE
  ///-------------------

  /// Step 1: Detect anomalies
  void _evaluateAnomalies() {
    final anomalyContext = AnomalyContext(
      entries: state,
      anomalies: ref.read(anomalyProvider),
    );

    final anomaly = anomalyEngine.evaluate(context: anomalyContext);

    if (anomaly == null) {
      return;
    }

    ref.read(anomalyProvider.notifier).register(anomaly);

    print('---- [ANOMALY_DETECTED] ----');
    // print(anomaly);

    _processAnomaly(anomaly);
  }

  /// Step 2: Resolve anomaly into an execution plan
  void _processAnomaly(Anomaly anomaly) {
    final effect = generateOutcomeEffect(anomaly: anomaly);

    if (effect == null) {
      return;
    }

    final execution = outcomeExecutor.execute(
      effect: effect,
      context: OutcomeContext(anomaly: anomaly, entries: state),
    );

    print(execution ?? 'no_effects');

    _applyOutcomeExecution(execution);
  }

  /// Step 3: Mutate state according to the execution plan
  void _applyOutcomeExecution(OutcomeExecution? execution) {
    if (execution == null) {
      return;
    }

    switch (execution) {
      case CreateEntryExecution():
        _insertEntry(
          title: execution.entrySeed.title,
          content: execution.entrySeed.rawContent,
          corruption: execution.profile,
        );
        break;
      case CorruptEntriesExecution():
        for (final corruption in execution.corruptions) {
          _applyCorruption(corruption.entryId, corruption.profile);
        }
        break;

      case AppendAnnotationExecution():
        addAnnotation(
          execution.entryId,
          execution.annotation,
          source: AnnotationSource.anomaly,
        );
        break;
      // futuros casos:
      //
      // case PushSystemMessageExecution():
      // case RetrieveArtifactExecution():
    }
  }
}
