import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';

class MenuPanelWidget extends StatelessWidget {
  const MenuPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
          Text('SYS_MENU // ROOT', 
            style: TextStyle(
              color: primaryColor.withValues(alpha: 0.8),
              shadows: [
                Shadow(
                  color: primaryColor.withValues(alpha: 0.8),
                  blurRadius: 2, 
                  offset: Offset(0, 0)
                ),
              ],
            ),
          ),
          Text('> [01] LOG_ENTRY', style: TextStyle(height: 0, color: primaryColor.withValues(alpha: 1))),
          Text('  [02] CHRONOLOGY', style: TextStyle(height: 0, color: primaryColor.withValues(alpha: 0.72))),
          Text('  [03] ARCHIVE', style: TextStyle(height: 0, color: primaryColor.withValues(alpha: 0.72))),
          Text('  [04] SYSTEM', style: TextStyle(height: 0, color: primaryColor.withValues(alpha: 0.72))),
        ],
      ),
    );
  }
}
