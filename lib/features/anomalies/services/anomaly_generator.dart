import 'dart:math';

import 'package:signal/features/anomalies/data/anomalies_catalog.dart';
import 'package:signal/features/anomalies/models/anomaly.dart';

abstract class AnomalyGenerator {
  Anomaly generate({
    required AnomalyType type,
    required AnomalyTrigger trigger,
  });
}

class RandomAnomalyGenerator implements AnomalyGenerator {
  final Random random = Random();

  @override
  Anomaly generate({
    required AnomalyType type,
    required AnomalyTrigger trigger,
  }) {
    final candidates = anomaliesCatalog.where((a) => a.type == type).toList();

    final template = candidates[random.nextInt(candidates.length)];

    return Anomaly(
      id: DateTime.now().millisecondsSinceEpoch.toString(),

      code: template.code,
      type: template.type,

      title: template.title,
      description: template.description,

      detectedAt: DateTime.now(),

      isPersistent: template.isPersistent,

      status: template.isPersistent
          ? AnomalyStatus.active
          : AnomalyStatus.resolved,

      lastOutcomeAt: null,
      trigger: trigger,
    );
  }
}
