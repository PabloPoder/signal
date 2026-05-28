import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';

class IdlePanelWidget extends StatelessWidget{

  const IdlePanelWidget({
    super.key,
  });

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
          Text('SYS_CORE // STANDBY', 
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
          Text('OPERATOR: AWAITING_AUTH', style: tertiaryTextStyle),
          Text('ENCRYPTION_KEY: LOADED', style: tertiaryTextStyle),
          Text('RADAR_DUMP: CLEAR', style: tertiaryTextStyle),
          Text(''),
          Text('[!] ENTER "/[option]"\nTO BRIDGE INTERFACE.', style: secondaryTextStyle),
        ],
      ),
    );
  }
}
