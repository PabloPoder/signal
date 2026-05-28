import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';

class AsciiBarWidget extends StatelessWidget {
  final double ratio;
  final String Function(double) builder;

  final bool showBrackets;
  final bool showPercentage;

  const AsciiBarWidget({
    super.key,
    required this.ratio,
    required this.builder,
    this.showBrackets = true,
    this.showPercentage = true,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0.0,
        end: ratio,
      ),
      duration: const Duration(milliseconds: 2000),
      curve: Curves.easeOutCubic,
      builder: (context, animatedRatio, child) {

        final currentPercentage =
            (animatedRatio * 100).toInt();

        String visual = builder(animatedRatio);

        if (showBrackets) {
          visual = '[$visual]';
        }

        if (showPercentage) {
          visual +=
              ' ${currentPercentage.toString().padLeft(3, '0')}%';
        }

        return Text(
          visual,
          style: secondaryTextStyle,
        );
      },
    );
  }
}