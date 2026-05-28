import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:signal/core/utils/ascii_visuals.dart';
import 'package:signal/core/utils/date_parser.dart';
import 'package:signal/core/widgets/ascii_bar_widget.dart';
import 'package:signal/features/entry/providers/entry_provider.dart';

class ChronologyIndexPanelWideg extends ConsumerWidget {
  const ChronologyIndexPanelWideg({super.key});

   @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(entryProvider);

    final int totalRecords = entries.length;
    final int corruptedCount = entries.where((e) => e.corruptionLevel > 0).length;
    
    final double targetIntegrityRatio = totalRecords == 0 ? 1.0 : ((totalRecords - corruptedCount) / totalRecords);
    final String archiveSpan;
    final String lastIndexSync;

    if(entries.isEmpty) {
      archiveSpan = '---- -- ----';
      lastIndexSync = '-- -- ----';
    } else {
      final int yearFirstEntry = entries.first.createdAt.year;
      final int yearLastEntry = entries.last.createdAt.year;
      archiveSpan = '$yearFirstEntry -- $yearLastEntry';
      lastIndexSync = formatTime(entries.last.createdAt);
    }

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
          Text('CHRONOLOGY // METRICS', 
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
            'TOTAL_RECORDS: ${totalRecords.toString().padLeft(3, '0')}_NODES', 
            style: tertiaryTextStyle,
          ),
          Text(
            'CORRUPTED_LN: ${corruptedCount.toString().padLeft(3, '0')}_SECTORS', 
            style: tertiaryTextStyle,
          ),
          Text(
            'DEGRADATION_RATE: 01.4%', 
            style: tertiaryTextStyle,
          ),
          Text(
            'ARCHIVE_SPAN: $archiveSpan', 
            style: tertiaryTextStyle,
          ),
          Text(
            'LAST_IDX_SYNC: $lastIndexSync',
            style: tertiaryTextStyle,
          ),
          Text(
            'INDEX_INTEGRITY: ${targetIntegrityRatio == 1.0 ? 'SECURE' : 'DEGRADED'} ', 
            style: secondaryTextStyle,
          ),
          AsciiBarWidget(
            ratio: targetIntegrityRatio, 
            builder: buildPercentageBar,
          ),
        ],
      ),
    );
  }
}
