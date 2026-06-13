import 'dart:math';

import 'package:signal/features/anomalies/models/anomaly.dart';
import 'package:signal/features/anomalies/models/anomaly_template.dart';
import 'package:signal/features/anomalies/services/anomaly_generator.dart';
import 'package:signal/features/entry/models/entry.dart';

/// THINGS THAT R NEEDED TO EVALUATE
class AnomalyContext {
  final List<Entry> entries;
  final List<Anomaly> anomalies;

  const AnomalyContext({required this.entries, required this.anomalies});
}

/// CONTRACT FOR RULES
abstract class IAnomalyRule {
  Anomaly? evaluate({required AnomalyContext context});
}

/// RULES
class EveryNEntriesRule implements IAnomalyRule {
  final AnomalyGenerator generator;

  EveryNEntriesRule(this.generator);

  @override
  Anomaly? evaluate({required AnomalyContext context}) {
    if (context.entries.isEmpty) return null;
    // TODO: change to 20
    if (context.entries.length % 1 != 0) {
      return null;
    }

    return generator.generate(
      type: AnomalyType.external,
      trigger: AnomalyTrigger.everyTenEntries,
    );
  }
}

class ThreeAmRule implements IAnomalyRule {
  final AnomalyGenerator generator;

  ThreeAmRule(this.generator);

  @override
  Anomaly? evaluate({required AnomalyContext context}) {
    final now = DateTime.now();

    final generatedToday = context.anomalies.where((anomaly) {
      return anomaly.trigger == AnomalyTrigger.threeAm &&
          anomaly.detectedAt.year == now.year &&
          anomaly.detectedAt.month == now.month &&
          anomaly.detectedAt.day == now.day;
    }).length;

    if (now.hour != 3) {
      return null;
    }

    if (generatedToday >= 1) {
      return null;
    }

    if (Random().nextDouble() > 0.2) {
      return null;
    }

    return generator.generate(
      type: AnomalyType.external,
      trigger: AnomalyTrigger.threeAm,
    );
  }
}

class RandomChanceRule implements IAnomalyRule {
  final AnomalyGenerator generator;

  RandomChanceRule(this.generator);

  @override
  Anomaly? evaluate({required AnomalyContext context}) {
    if (Random().nextDouble() > 0.02) {
      return null;
    }

    final lastAnomaly = context.anomalies.isEmpty
        ? null
        : context.anomalies.last;

    if (lastAnomaly != null &&
        DateTime.now().difference(lastAnomaly.detectedAt).inHours < 12) {
      return null;
    }

    return generator.generate(
      type: AnomalyType.external,
      trigger: AnomalyTrigger.randomChance,
    );
  }
}

class LongSilenceRule implements IAnomalyRule {
  final AnomalyGenerator generator;

  LongSilenceRule(this.generator);

  @override
  Anomaly? evaluate({required AnomalyContext context}) {
    if (Random().nextDouble() > 0.02) {
      return null;
    }

    final lastEntry = context.entries.last;

    final silenceDuration = DateTime.now()
        .difference(lastEntry.createdAt)
        .inHours;

    if (silenceDuration < 72) {
      return null;
    }

    return generator.generate(
      type: AnomalyType.external,
      trigger: AnomalyTrigger.longSilence,
    );
  }
}

class OperatorReturnRule implements IAnomalyRule {
  final AnomalyGenerator generator;

  OperatorReturnRule(this.generator);

  @override
  Anomaly? evaluate({required AnomalyContext context}) {
    if (Random().nextDouble() > 0.02) {
      return null;
    }

    final lastEntry = context.entries.last;

    final silenceDuration = DateTime.now()
        .difference(lastEntry.createdAt)
        .inDays;

    if (silenceDuration < 7) {
      return null;
    }

    return generator.generate(
      type: AnomalyType.external,
      trigger: AnomalyTrigger.abandonedArchive,
    );
  }
}

// TODO: RecoveryRule
// Trigger:  updateEntry()
// Condition: corruptionLevel decreases
