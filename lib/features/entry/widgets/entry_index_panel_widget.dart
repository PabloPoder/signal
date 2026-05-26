import 'dart:math';

import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';

class EntryIndexPanelWidget extends StatelessWidget {
  final TextEditingController controller;
  final autoSaveNode = Random().nextInt(100);
  final maxBufferCapacity = 500;


  EntryIndexPanelWidget({
    super.key,
    required this.controller,
  });


  @override
  Widget build(BuildContext context) {
    
    final date =  DateTime.now();
    final int year = date.year;
    final int month = date.month;
    final int day = date.day;

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
          Text('ENTRY // INDEX', 
            style: secondaryTextStyle
          ),
          Text('LOCAL_WRITE: ACTIVE', style: tertiaryTextStyle),
          Text('TEXT_INTEGRITY: 98.2%', style: tertiaryTextStyle),
          Text('AUTOSAVE_NODE: E-$autoSaveNode', style: tertiaryTextStyle),
          Text('TIME_STAMP: $day $month $year', style: tertiaryTextStyle),
          ListenableBuilder(
            listenable: controller, 
            builder: (context, child) {
              final text = controller.text;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._buildTextCounters(text),
                  ..._buildProgressBar(text.length)
                ],
              );
            }
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

  List<Widget> _buildProgressBar(int charCount) {
    final double usageRatio = (charCount / maxBufferCapacity).clamp(0.0, 1.0);
    final int usagePercentage = (usageRatio * 100).toInt();

    const int totalBlocks = 10;
    final int filledBlocks = (usageRatio * totalBlocks).round();
    final int emptyBlocks = totalBlocks - filledBlocks;
    String progressBar = ('█' * filledBlocks); 
    if (emptyBlocks > 0) {
      progressBar += '▒${'░' * (emptyBlocks -1 )}';
    }

    return [
      Text('BUFFER_USAGE: $usagePercentage%', style: secondaryTextStyle),
      Text('[$progressBar]', style: secondaryTextStyle),
    ];
  }
}

