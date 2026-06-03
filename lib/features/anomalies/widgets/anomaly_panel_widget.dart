import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:signal/features/anomalies/models/anomaly.dart';
import 'package:signal/features/anomalies/providers/anomaly_provider.dart';
import 'package:signal/features/anomalies/widgets/anomaly_detecting_panel_widget.dart';
import 'package:signal/features/anomalies/widgets/anomaly_idle_panel_widget.dart';
import 'package:signal/features/anomalies/widgets/anomaly_tracked_panel_widget.dart';

enum PanelState { idle, detecting, tracked }

class AnomalyPanelWidget extends ConsumerStatefulWidget {
  const AnomalyPanelWidget({super.key});

  @override
  ConsumerState<AnomalyPanelWidget> createState() => _AnomalyPanelWidgetState();
}

class _AnomalyPanelWidgetState extends ConsumerState<AnomalyPanelWidget> {
  PanelState panelState = PanelState.idle;

  Anomaly? currentAnomaly;
  static const detectionDuration = Duration(seconds: 8);
  static const trackedDuration = Duration(minutes: 2);

  Timer? detectionTimer;
  Timer? trackedTimer;

  void _handleNewAnomaly(Anomaly anomaly) {
    currentAnomaly = anomaly;

    detectionTimer?.cancel();
    trackedTimer?.cancel();

    setState(() {
      panelState = PanelState.detecting;
    });
    detectionTimer = Timer(detectionDuration, () {
      if (!mounted) return;

      setState(() {
        panelState = PanelState.tracked;
      });

      trackedTimer = Timer(trackedDuration, () {
        if (!mounted) return;

        setState(() {
          panelState = PanelState.idle;
        });
      });
    });
  }

  @override
  void dispose() {
    detectionTimer?.cancel();
    trackedTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anomalies = ref.watch(anomalyProvider);

    final latestAnomaly = anomalies.isNotEmpty ? anomalies.last : null;

    if (latestAnomaly != null && latestAnomaly.id != currentAnomaly?.id) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleNewAnomaly(latestAnomaly);
      });
    }

    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: BoxBorder.fromLTRB(
          bottom: BorderSide(
            width: 1.5,
            color: primaryColor.withValues(alpha: 0.35),
          ),
          right: BorderSide(
            width: 1.5,
            color: primaryColor.withValues(alpha: 0.35),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SIGNAL_ANALYZER // ACTIVE', style: secondaryTextStyle),
          switch (panelState) {
            PanelState.idle => AnomalyIdlePanelWidget(),
            PanelState.detecting => AnomalyDetectingPanelWidget(
              displayDuration: detectionDuration,
            ),
            PanelState.tracked => AnomalyTrackedPanelWidget(
              anomaly: currentAnomaly!,
            ),
          },
        ],
      ),
    );
  }
}
