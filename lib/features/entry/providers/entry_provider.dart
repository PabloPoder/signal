import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/features/anomalies/models/anomaly.dart';
import 'package:signal/features/anomalies/models/anomaly_rules/ianomaly_rule.dart';
import 'package:signal/features/anomalies/models/anomaly_rules/ioutcome_rule.dart';
import 'package:signal/features/anomalies/providers/anomaly_provider.dart';
import 'package:signal/features/anomalies/services/anomaly_engine.dart';
import 'package:signal/features/anomalies/services/outcome_executor.dart';
import 'package:signal/features/anomalies/services/outcome_generator.dart';
import 'package:signal/features/entry/models/annotation/annotation.dart';
import 'package:signal/features/entry/models/corruption_profile.dart';
import 'package:signal/features/entry/models/entry.dart';
import 'package:signal/features/entry/models/repositories/entry_repository.dart';
import 'package:signal/features/entry/models/repositories/in_memory_entry_repository.dart';
import 'package:signal/features/entry/providers/anomaly_engine_provider.dart';

final entryRepositoryProvider = Provider<EntryRepository>((ref) {
  return InMemoryEntryRepository();
});

final entryProvider = NotifierProvider<EntryNotifier, List<Entry>>(
  EntryNotifier.new,
);

class EntryNotifier extends Notifier<List<Entry>> {
  late final EntryRepository _repository;
  late final AnomalyEngine anomalyEngine;

  final SignalOutcomeExecutor outcomeExecutor = SignalOutcomeExecutor();

  @override
  List<Entry> build() {
    _repository = ref.read(entryRepositoryProvider);
    anomalyEngine = ref.read(anomalyEngineProvider);

    return _repository.getAll();
  }

  void _refreshState() {
    state = [..._repository.getAll()];
  }

  List<Entry> getEntries() => state;

  Entry createEntry({required String title, required String content}) {
    final entry = Entry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      rawContent: content,
      annotations: const [],
      createdAt: DateTime.now(),
      recoverability: 100,
      overwriteCount: 0,
    );

    _repository.add(entry);

    _refreshState();

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

  void applyCorruption(String entryId, CorruptionProfile corruption) {
    final entry = findEntry(entryId);

    if (entry == null) return;

    final merged = entry.corruption.merge(corruption);

    updateEntry(entry.copyWith(corruption: merged));
  }

  Entry? findEntry(String id) {
    try {
      return state.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  void incrementOverwriteCount(String entryId) {
    final entry = findEntry(entryId);

    if (entry == null) return;

    updateEntry(entry.copyWith(overwriteCount: entry.overwriteCount + 1));
  }

  Entry? addAnnotation(String entryId, String note) {
    final entry = findEntry(entryId);

    if (entry == null) return null;

    final annotation = Annotation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      content: note,
    );

    final updatedEntry = entry.copyWith(
      annotations: [...entry.annotations, annotation],
    );

    updateEntry(updatedEntry);

    return updatedEntry;
  }

  ///-------------------
  /// ANOMALIES
  ///-------------------
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

    print('');
    print(anomaly);

    _processAnomaly(anomaly);
  }

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

  void _applyOutcomeExecution(OutcomeExecution? execution) {
    if (execution == null) {
      return;
    }

    switch (execution) {
      case CorruptEntriesExecution():
        for (final corruption in execution.corruptions) {
          applyCorruption(corruption.entryId, corruption.profile);
        }

      // futuros casos:
      //
      // case CreateEntryExecution():
      // case AppendAnnotationExecution():
      // case PushSystemMessageExecution():
      // case RetrieveArtifactExecution():
    }
  }
}
