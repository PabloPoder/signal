import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/features/anomalies/models/anomaly_rules/ianomaly_rule.dart';
import 'package:signal/features/anomalies/services/anomaly_engine.dart';
import 'package:signal/features/anomalies/services/anomaly_generator.dart';

final anomalyEngineProvider = Provider<AnomalyEngine>((ref) {
  final generator = RandomAnomalyGenerator();

  return AnomalyEngine(
    rules: [EveryNEntriesRule(generator), ThreeAmRule(generator)],
  );
});
