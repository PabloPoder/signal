import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:signal/core/utils/ascii_visuals.dart';
import 'package:signal/core/utils/date_parser.dart';
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

    final corruptionRatio =
      (entry.corruptionLevel / 100).clamp(0.0, 1.0);

    final integrityRatio = 1 - corruptionRatio;

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
            'DATE_CREATED: ${formatTime(entry.createdAt)}',
            style: tertiaryTextStyle,
          ),
          // Text(
          //   'OVERWRITE_CNT: ${entry.overwriteCnt}',
          //   style: tertiaryTextStyle,
          // ),
          ..._buildTextCounters(entry.content),
          Text(
            'MEMORY_INTEGRITY:',
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
            ratio: corruptionRatio,
            builder: buildFragmentationPattern,
            showBrackets: false,
            showPercentage: false,
          ),
        ],
      ),
    );
  }

List<Widget> _buildTextCounters(String text) {
    final charCount = text.length;
    
    final wordCount = text.trim().isEmpty
        ? 0
        : text.trim().split(RegExp(r'\s+')).length;

    return [
      Text(
        'WORD_CNT: ${wordCount.toString().padLeft(3, '0')}', 
        style: tertiaryTextStyle,
      ),
      Text(
        'CHAR_CNT: ${charCount.toString().padLeft(3, '0')}', 
        style: tertiaryTextStyle,
      ),
    ];
  }
}
