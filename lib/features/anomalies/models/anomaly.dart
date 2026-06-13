import 'package:signal/features/anomalies/models/anomaly_template.dart';

enum AnomalyTrigger {
  threeAm,
  everyTenEntries,
  randomChance,
  longSilence,
  abandonedArchive,
}

class Anomaly {
  final String id;
  final DateTime detectedAt;
  final AnomalyTemplate template;

  /// For dev_log
  final AnomalyTrigger trigger;

  const Anomaly({
    required this.id,
    required this.detectedAt,
    required this.template,
    required this.trigger,
  });

  Anomaly copyWith() {
    return Anomaly(
      id: id,
      detectedAt: detectedAt,
      template: template,
      trigger: trigger,
    );
  }

  @override
  String toString() {
    return '''
---- [ANOMALY] ----
detectedAt: $detectedAt
$template
''';
  }
}
