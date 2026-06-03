
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/features/anomalies/models/anomaly.dart';

final anomalyProvider =
    NotifierProvider<AnomalyNotifier, List<Anomaly>>(
      AnomalyNotifier.new,
    );

class AnomalyNotifier extends Notifier<List<Anomaly>> {

  @override
  List<Anomaly> build() => [];

  void register(Anomaly anomaly) {
    state = [...state, anomaly];
  }
}