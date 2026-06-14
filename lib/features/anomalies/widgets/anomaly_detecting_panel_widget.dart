import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:signal/core/utils/ascii_visuals.dart';
import 'package:signal/core/widgets/ascii_bar_widget.dart';
import 'package:signal/features/anomalies/utils/anomaly_ascii_animation.dart';

class AnomalyDetectingPanelWidget extends StatefulWidget {
  final Duration displayDuration;

  const AnomalyDetectingPanelWidget({super.key, required this.displayDuration});

  @override
  State<AnomalyDetectingPanelWidget> createState() =>
      _AnomalyDetectingPanelWidgetState();
}

class _AnomalyDetectingPanelWidgetState
    extends State<AnomalyDetectingPanelWidget> {
  int frameIndex = 0;
  double progressRatio = 0.0;
  Timer? timer;

  late AnomalyAsciiAnimation currentAnimation;

  @override
  void initState() {
    super.initState();

    final random = Random();
    currentAnimation =
        anomaliesAsciiAnimationCatalog[random.nextInt(
          anomaliesAsciiAnimationCatalog.length,
        )];

    const tickDuration = Duration(milliseconds: 100);
    final totalTicks =
        widget.displayDuration.inMilliseconds / tickDuration.inMilliseconds;
    int currentTick = 0;

    timer = Timer.periodic(tickDuration, (_) {
      if (!mounted) return;

      setState(() {
        currentTick++;

        progressRatio = (currentTick / totalTicks).clamp(0.0, 1.0);

        frameIndex++;

        if (progressRatio >= 1.0) {
          timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String _buildDetectingContent() {
    final frames = currentAnimation.frames;

    final currentFrame = frames[frameIndex % frames.length];

    return currentAnimation.templateBuilder(currentFrame);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('[ANOMALY_DETECTED]', style: tertiaryTextStyle),
        Text(_buildDetectingContent(), style: tertiaryTextStyle),
        buildDataBox(
          title: 'DETECTION',
          widgets: [
            AsciiBarWidget(ratio: progressRatio, builder: buildPercentageBar),
          ],
        ),
      ],
    );
  }
}
