import 'package:signal/features/anomalies/models/anomaly.dart';
import 'package:signal/features/anomalies/models/anomaly_rules/ianomaly_rule.dart';

class AnomalyEngine {
  final List<IAnomalyRule> rules;

  const AnomalyEngine({required this.rules});

  Anomaly? evaluate({required AnomalyContext context}) {
    for (final rule in rules) {
      final anomaly = rule.evaluate(context: context);

      if (anomaly != null) {
        return anomaly;
      }
    }

    return null;
  }
}
