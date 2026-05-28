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
                  _buildAnimatedProgressBar(text.length)
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

  Widget _buildAnimatedProgressBar(int charCount) {
    final double targetUsageRatio = (charCount / maxBufferCapacity).clamp(0.0, 1.0);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: targetUsageRatio),
      duration: const Duration(milliseconds: 350), 
      curve: Curves.easeOutQuad,
      builder: (context, animatedRatio, child) {
        final int currentPercentage = (animatedRatio * 100).toInt();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('BUFFER_USAGE: ${currentPercentage.toString().padLeft(3, '0')}%', style: secondaryTextStyle),
            Text('[${_buildASCIIBar(animatedRatio)}]', style: secondaryTextStyle),
          ],
        );
      },
    );
  }


  String _buildASCIIBar(double usageRatio) {
    const int totalBlocks = 10; 
    final double preciseFilledBlocks = usageRatio * totalBlocks;
    final int filledBlocks = preciseFilledBlocks.floor();
    
    String progressBar = '█' * filledBlocks; 

    if (filledBlocks < totalBlocks) {
      final double remainder = preciseFilledBlocks - filledBlocks;
      
      if (remainder >= 0.7) {
        progressBar += '█'; 
      } else if (remainder >= 0.4) {
        progressBar += '▒'; 
      } else if (remainder > 0.0) {
        progressBar += '░'; 
      } else {
        progressBar += '░'; 
      }
      
      final int remainingEmpty = totalBlocks - progressBar.characters.length;
      if (remainingEmpty > 0) {
        progressBar += '░' * remainingEmpty;
      }
    }

    return progressBar;
  }

}