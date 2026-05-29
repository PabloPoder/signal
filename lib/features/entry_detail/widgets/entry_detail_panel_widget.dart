import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:signal/core/utils/ascii_visuals.dart';
import 'package:signal/core/widgets/ascii_bar_widget.dart';
import 'package:signal/features/entry/models/entry.dart';

class EntryDeatilPanelWidget extends StatelessWidget {
  final Entry entry;
  
  const EntryDeatilPanelWidget({
    super.key, 
    required this.entry
  });

  @override
  Widget build(BuildContext context) {

    final dataFragmentation =
      (entry.corruptionLevel / 100).clamp(0.0, 1.0);

    final integrityRatio = 1 - dataFragmentation;

   final recoverabilityTag =
      entry.recoverability > 80
          ? 'VIABLE'
          : entry.recoverability > 40
              ? 'PARTIAL'
              : 'COLLAPSE';
              
    final signalNoiseTag = 
      entry.corruption.signalNoise > 60
        ? 'CRITICAL'
        : entry.corruption.signalNoise > 25
            ? 'UNSTABLE'
            : 'LOW';

    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: BoxBorder.fromLTRB(
          bottom: BorderSide(width: 1.5, color: primaryColor.withValues(alpha: 0.35)),
          right: BorderSide(width: 1.5, color: primaryColor.withValues(alpha: 0.35))
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ENTRY_DETAIL // METRICS', 
            style: TextStyle(
              color: primaryColor.withValues(alpha: 0.8),
              shadows: [
                Shadow(
                  color: primaryColor.withValues(alpha: 0.8),
                  blurRadius: 2, 
                  offset: Offset.zero
                ),
              ],
            ),
          ),
          Text(
            'OVERWRITE_COUNT: ${entry.overwriteCount.toString().padLeft(3, '0')}',
            style: tertiaryTextStyle,
          ),
          Text(
            'SIGNAL_NOISE: $signalNoiseTag',
            style: tertiaryTextStyle,
          ),
          Text(
            'RECOVERABILITY: $recoverabilityTag',
            style: tertiaryTextStyle,
          ),
          Text(
            'ARCHIVE_INTEGRITY:',
            style: secondaryTextStyle,
          ),
          AsciiBarWidget(
            ratio: integrityRatio, 
            builder: buildPercentageBar,
          ),
          Text(
            'DATA_FRAGMENTATION:',
            style: secondaryTextStyle,
          ),
          AsciiBarWidget(
            ratio: dataFragmentation,
            builder: buildFragmentationPattern,
            showBrackets: false,
            showPercentage: false,
          ),
        ],
      ),
    );
  }
}