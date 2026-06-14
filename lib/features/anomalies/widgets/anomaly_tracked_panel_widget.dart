import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:signal/core/utils/ascii_visuals.dart';
import 'package:signal/core/utils/date_parser.dart';
import 'package:signal/core/widgets/ascii_bar_widget.dart';
import 'package:signal/features/anomalies/models/anomaly.dart';

class AnomalyTrackedPanelWidget extends StatelessWidget {
  final Anomaly anomaly;

  const AnomalyTrackedPanelWidget({super.key, required this.anomaly});

  @override
  Widget build(BuildContext context) {
    final lastOutcome = formatTime(anomaly.detectedAt);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CODE: ${anomaly.template.code}', style: tertiaryTextStyle),
        Text(
          'SOURCE: ${anomaly.template.type.name.toUpperCase()}',
          style: tertiaryTextStyle,
        ),
        Text('DETECT_TIME: $lastOutcome', style: tertiaryTextStyle),
        Text('STATUS: RESOLVED'),
        buildDataBox(
          title: 'SIGNAL_LOCK',
          widgets: [AsciiBarWidget(ratio: 1, builder: buildPercentageBar)],
        ),
        Text('[i] ANOMALY_ARCHIVED', style: warningTextStyle),
      ],
    );
  }
}
