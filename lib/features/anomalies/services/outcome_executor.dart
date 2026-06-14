import 'dart:math';

import 'package:signal/features/anomalies/models/anomaly.dart';
import 'package:signal/features/anomalies/models/anomaly_rules/ioutcome_rule.dart';
import 'package:signal/features/anomalies/services/outcome_generator.dart';
import 'package:signal/features/anomaly_outcomes/data/annotations_catalog.dart';
import 'package:signal/features/anomaly_outcomes/data/corruption_profiles_catalog.dart';
import 'package:signal/features/anomaly_outcomes/data/entries_catalog.dart';
import 'package:signal/features/anomaly_outcomes/models/corruption_profile.dart';
import 'package:signal/features/entry/models/entry.dart';

/// Data avaible when evaluating an anomaly outcome.
class OutcomeContext {
  final Anomaly anomaly;
  final List<Entry> entries;

  const OutcomeContext({required this.entries, required this.anomaly});
}

/// Generates inmutable instruction describing anomaly consecuenses.
abstract class OutcomeExecutor {
  OutcomeExecution? execute({
    required OutcomeEffect effect,
    required OutcomeContext context,
  });
}

/// Default implementation reponsible for translating anomlay effects
/// into concrete outcome executions.
class SignalOutcomeExecutor implements OutcomeExecutor {
  final Random random = Random();

  @override
  OutcomeExecution? execute({
    required OutcomeEffect effect,
    required OutcomeContext context,
  }) {
    print(effect.name.toString().toUpperCase());
    switch (effect) {
      case OutcomeEffect.corruptEntries:
        return _corruptEntriesExecution(context);

      case OutcomeEffect.createEntry:
        return _createEntryExecution(context);

      case OutcomeEffect.appendAnnotation:
        return _appendAnnotationExecution(context);
      case OutcomeEffect.pushSystemMessage:
      // return _pushSystemMessage(context);

      case OutcomeEffect.retrieveArtifact:
      // return _retrieveArtifact(context);
    }

    return null;
  }

  /// Creates a mood-driven entry, optionally corrupted.
  CreateEntryExecution? _createEntryExecution(OutcomeContext context) {
    // getting an entry preset
    final entries = entriesCatalog[context.anomaly.template.mood];
    if (entries == null || entries.isEmpty) return null;
    final entry = entries[random.nextInt(entries.length)];

    // getting a corruption preset: chance of not getting a corruption
    CorruptionProfile? profile;
    if (random.nextBool()) {
      final profiles = corruptionCatalog[context.anomaly.template.mood];
      if (profiles != null && profiles.isNotEmpty) {
        profile = profiles[random.nextInt(profiles.length)];
      }
    }

    return CreateEntryExecution(entrySeed: entry, profile: profile);
  }

  /// Corrupts a random set of existing entries.
  CorruptEntriesExecution? _corruptEntriesExecution(OutcomeContext context) {
    if (context.entries.isEmpty) return null;

    final countEntriesToAffect = min(
      random.nextInt(3) + 1,
      context.entries.length,
    );

    final targets = [...context.entries]..shuffle();

    final corruptions = <EntryCorruptionInstruction>[];

    final profiles = corruptionCatalog[context.anomaly.template.mood];

    if (profiles == null || profiles.isEmpty) return null;

    final profile = profiles[random.nextInt(profiles.length)];

    for (final entry in targets.take(countEntriesToAffect)) {
      corruptions.add(
        EntryCorruptionInstruction(entryId: entry.id, profile: profile),
      );
    }

    return CorruptEntriesExecution(corruptions: corruptions);
  }

  ///Adds a random annotation (from the catalog) to an existing entry
  AppendAnnotationExecution? _appendAnnotationExecution(
    OutcomeContext context,
  ) {
    if (context.entries.isEmpty) return null;

    final entryTarget = context.entries[random.nextInt(context.entries.length)];

    final annotations = annotationsCatalog[context.anomaly.template.mood];

    if (annotations == null || annotations.isEmpty) return null;

    final annotation = annotations[random.nextInt(annotations.length)];

    return AppendAnnotationExecution(
      entryId: entryTarget.id,
      annotation: annotation,
    );
  }
}
