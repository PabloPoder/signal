import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';

String buildPercentageBar(double integrityRatio) {
  const int totalBlocks = 9;

  final double preciseFilledBlocks = integrityRatio * totalBlocks;

  final int filledBlocks = preciseFilledBlocks.floor();

  String bar = '';

  for (int i = 0; i < totalBlocks; i++) {
    if (i < filledBlocks) {
      bar += '█';
    } else {
      final remainder = preciseFilledBlocks - filledBlocks;

      if (i == filledBlocks && remainder >= 0.5) {
        bar += '▒';
      } else {
        bar += '░';
      }
    }
  }

  return bar;
}

String buildFragmentationPattern(double ratio) {
  const totalBlocks = 8;

  final corruption = (ratio * totalBlocks).round();

  final chars = List.generate(totalBlocks, (_) => '·');

  for (int i = 0; i < corruption; i++) {
    final seed = (i * 7 + corruption) % 6;

    if (seed == 0) {
      chars[i] = '╳';
    } else if (seed <= 2) {
      chars[i] = '▚';
    } else {
      chars[i] = '▒';
    }
  }

  return chars.join(' ');
}

(String wordCount, String charCount) buildTextCounters(String text) {
  final charCount = text.length;

  final wordCount = text.trim().isEmpty
      ? 0
      : text.trim().split(RegExp(r'\s+')).length;

  return (
    wordCount.toString().padLeft(3, '0'),
    charCount.toString().padLeft(3, '0'),
  );
}

Widget buildDataBox({required String title, required List<Widget> widgets}) {
  final panelWidth = 25;
  final oddTitle = title.length % 2 == 0
      ? title.substring(0, title.length - 1)
      : title;

  final linesToDraw =
      (panelWidth - oddTitle.length) - 4; // 4 is for "┌ " and " ┐"
  final leftLines = '┌${'─' * ((linesToDraw / 2).floor())}';
  final rightLines = '─' * (linesToDraw / 2).ceil() + '┐';

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('$leftLines $oddTitle $rightLines', style: tertiaryTextStyle),
      ...widgets.map((widget) {
        if (widget is Text) {
          final orignalData = widget.data ?? '';

          return Text(
            ' $orignalData',
            style: widget.style,
            textAlign: widget.textAlign,
          );
        }
        return widget;
      }),
      Text('└${'─' * (panelWidth - 2)}┘', style: tertiaryTextStyle),
    ],
  );
}
