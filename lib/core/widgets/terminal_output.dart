import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';

class TerminalOutput extends StatelessWidget {

  final String output;
  
  const TerminalOutput({
    super.key,
    required this.output,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      child: Text(
        output,
        style: TextStyle(
          color: primaryColor.withValues(alpha: 0.8),
          shadows: [
            Shadow(
              color: primaryColor.withValues(alpha: 0.8),
              blurRadius: 2,
              offset: Offset.zero,
            ),
          ],
        ),
      ),
    );
  }
}
