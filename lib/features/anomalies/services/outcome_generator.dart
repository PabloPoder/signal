import 'dart:math';

import 'package:signal/features/anomalies/models/anomaly.dart';

enum OutcomeEffect {
  createEntry,
  corruptEntries,
  appendAnnotation,
  pushSystemMessage,
  retrieveArtifact,
}

OutcomeEffect? generateOutcomeEffect({required Anomaly anomaly}) {
  final Random random = Random();
  final rolls = {
    OutcomeEffect.createEntry:
        random.nextDouble() * anomaly.template.createEntryChance,

    OutcomeEffect.corruptEntries:
        random.nextDouble() * anomaly.template.corruptEntriesChance,

    OutcomeEffect.appendAnnotation:
        random.nextDouble() * anomaly.template.appendAnnotationChance,

    OutcomeEffect.pushSystemMessage:
        random.nextDouble() * anomaly.template.pushSystemMessageChance,

    OutcomeEffect.retrieveArtifact:
        random.nextDouble() * anomaly.template.retrieveArtifactChance,
  };

  final winner = rolls.entries.reduce((a, b) => a.value > b.value ? a : b);

  // TODO: delete this comments
  // print('---- [CHANCE TO APPLY EFFECTS] ----');
  // print('chance: ${winner.value.toStringAsFixed(1)}');
  // print('effect: ${winner.key.toString()}');

  return winner.value <= 0 ? null : OutcomeEffect.appendAnnotation;

  // return winner.value <= 0 ? null : winner.key;
}
