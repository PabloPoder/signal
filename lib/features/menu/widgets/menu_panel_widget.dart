import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:signal/core/utils/ascii_visuals.dart';
import 'package:signal/features/menu/models/menu_option.dart';
import 'package:signal/features/menu/data/menu_options.dart';

class MenuPanelWidget extends StatelessWidget {
  final MenuSection selectedSection;

  const MenuPanelWidget({super.key, required this.selectedSection});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: BoxBorder.fromLTRB(
          bottom: BorderSide(
            width: 1.5,
            color: primaryColor.withValues(alpha: 0.35),
          ),
          right: BorderSide(
            width: 1.5,
            color: primaryColor.withValues(alpha: 0.35),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SYS_MENU // ROOT', style: secondaryTextStyle),

          ...List.generate(menuOptions.length, (index) {
            final option = menuOptions[index];

            final selected = selectedSection == option.section;

            return Text(
              selected ? '> ${option.label}' : '  ${option.label}',

              style: selected ? secondaryTextStyle : tertiaryTextStyle,
            );
          }),
          Text(''),
          buildDataBox(
            title: "OPERATOR_ID",
            widgets: [
              Text('AUTH : LEVEL_03 // CORE', style: tertiaryTextStyle),
              Text('TERM : TTY_02 (VIRTUAL)', style: tertiaryTextStyle),
            ],
          ),
        ],
      ),
    );
  }
}
