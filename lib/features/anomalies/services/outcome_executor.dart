import 'dart:math';

import 'package:signal/features/anomalies/models/anomaly.dart';
import 'package:signal/features/anomalies/models/anomaly_rules/ioutcome_rule.dart';
import 'package:signal/features/anomalies/services/outcome_generator.dart';
import 'package:signal/features/entry/data/corruption_profiles_catalog.dart';
import 'package:signal/features/entry/models/corruption_profile.dart';
import 'package:signal/features/entry/models/entry.dart';

class OutcomeContext {
  final Anomaly anomaly;
  final List<Entry> entries;

  const OutcomeContext({required this.entries, required this.anomaly});
}

abstract class OutcomeExecutor {
  OutcomeExecution? execute({
    required OutcomeEffect effect,
    required OutcomeContext context,
  });
}

class SignalOutcomeExecutor implements OutcomeExecutor {
  final Random random = Random();

  @override
  OutcomeExecution? execute({
    required OutcomeEffect effect,
    required OutcomeContext context,
  }) {
    switch (effect) {
      case OutcomeEffect.corruptEntries:
        return _corruptEntries(context);

      case OutcomeEffect.createEntry:
      // return _createEntry(context);

      case OutcomeEffect.appendAnnotation:
      // return _appendAnnotation(context);
      case OutcomeEffect.pushSystemMessage:
      // return _pushSystemMessage(context);

      case OutcomeEffect.retrieveArtifact:
      // return _retrieveArtifact(context);
    }

    return null;
  }

  CorruptEntriesExecution? _corruptEntries(OutcomeContext context) {
    if (context.entries.isEmpty) {
      return null;
    }

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
}
