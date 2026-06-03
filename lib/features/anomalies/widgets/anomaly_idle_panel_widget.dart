import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:signal/core/utils/ascii_visuals.dart';
import 'package:signal/core/widgets/ascii_bar_widget.dart';

class AnomalyIdlePanelWidget extends StatefulWidget {
  const AnomalyIdlePanelWidget({super.key});

  @override
  State<AnomalyIdlePanelWidget> createState() => _AnomalyIdlePanelWidgetState();
}

class _AnomalyIdlePanelWidgetState extends State<AnomalyIdlePanelWidget> {
  late Timer timer;

  int frameIndex = 0;
  double bufferPercentage = 0.35;
  int gain = 0;

  Random random = Random();

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      if (!mounted) return;

      setState(() {
        frameIndex++;
        bufferPercentage += random.nextDouble() * 4 - 2;
        bufferPercentage = bufferPercentage.clamp(0.30, 0.35);
        gain = random.nextInt(4);
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('波形稳定 ──── 0.1${gain}dB', style: tertiaryTextStyle),
        Text(
          '内部温度 ──── ${(41.2 + (gain * 0.3)).toStringAsFixed(2)}°C',
          style: tertiaryTextStyle,
        ), // Internal Temp
        buildDataBox(
          title: 'ENV_STATS',
          widgets: [
            Text(
              'WAVE_OSC: 1420.40${frameIndex % 9} MHz',
              style: tertiaryTextStyle,
            ),
            Text('ANT_DRFT: 0.00$gain°/sec', style: tertiaryTextStyle),
            Text(
              'BACK_RAD: 2.73${frameIndex % 9}K(±${(bufferPercentage * gain).toStringAsFixed(2)})',
              style: tertiaryTextStyle,
            ),
            AsciiBarWidget(
              ratio: bufferPercentage,
              builder: buildPercentageBar,
            ),
          ],
        ),
      ],
    );
  }
}
