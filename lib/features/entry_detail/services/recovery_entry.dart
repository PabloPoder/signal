import 'dart:math';

import 'package:signal/features/anomaly_outcomes/models/corruption_profile.dart';
import 'package:signal/features/entry/models/entry.dart';

enum RecoveryOutcome { success, failure }

class RecoveryResult {
  final RecoveryOutcome outcome;
  final CorruptionProfile corruption;
  final int recoverability;

  const RecoveryResult({
    required this.outcome,
    required this.corruption,
    required this.recoverability,
  });
}

class RecoveryService {
  static int calculateRecoverability(Entry entry) {
    final penalty = entry.overwriteCount * 15;

    final corruptionPenalty = (entry.corruption.totalLevel * 0.5).round();

    return (100 - penalty - corruptionPenalty).clamp(0, 100);
  }

  CorruptionProfile _repair(CorruptionProfile corruption, int recoverability) {
    final factor = recoverability / 100;

    return corruption.copyWith(
      echoIntensity: (corruption.echoIntensity * (1 - factor)).round(),
      memoryDecay: (corruption.memoryDecay * (1 - factor)).round(),
      semanticDrift: (corruption.semanticDrift * (1 - factor)).round(),
      signalNoise: (corruption.signalNoise * (1 - factor)).round(),
      structuralCollapse: (corruption.structuralCollapse * (1 - factor))
          .round(),
    );
  }

  CorruptionProfile _worsen(CorruptionProfile corruption) {
    return corruption.copyWith(
      echoIntensity: (corruption.echoIntensity + 10).clamp(0, 100),
      memoryDecay: (corruption.memoryDecay + 10).clamp(0, 100),
      semanticDrift: (corruption.semanticDrift + 10).clamp(0, 100),
      signalNoise: (corruption.signalNoise + 10).clamp(0, 100),
      structuralCollapse: (corruption.structuralCollapse + 10).clamp(0, 100),
    );
  }

  RecoveryResult attemptRecovery(Entry entry) {
    final recoverability = calculateRecoverability(entry);

    final roll = Random().nextInt(100);

    if (roll < recoverability) {
      return RecoveryResult(
        outcome: RecoveryOutcome.success,
        corruption: _repair(entry.corruption, recoverability),
        recoverability: recoverability,
      );
    }

    return RecoveryResult(
      outcome: RecoveryOutcome.failure,
      corruption: _worsen(entry.corruption),
      recoverability: recoverability,
    );
  }
}
