import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';

class HeaderLogoWidget extends StatefulWidget {
  const HeaderLogoWidget({super.key});

  @override
  State<HeaderLogoWidget> createState() => _HeaderLogoWidgetState();
}

class _HeaderLogoWidgetState extends State<HeaderLogoWidget> {
  static const String asciiLogo = """
███████╗██╗ ██████╗ ███╗   ██╗ █████╗ ██╗     
██╔════╝██║██╔════╝ ████╗  ██║██╔══██╗██║     
███████╗██║██║  ███╗██╔██╗ ██║███████║██║     
╚════██║██║██║   ██║██║╚██╗██║██╔══██║██║     
███████║██║╚██████╔╝██║ ╚████║██║  ██║███████╗
╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝
Personal Archive System""";

  late DateTime _currentTime;
  static const months = [
    'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
    'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
  ];


  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    Future.delayed(const Duration(seconds: 1), _updateTime);
  }

  void _updateTime() {
    if (mounted) {
      setState(() {
        _currentTime = DateTime.now();
      });
      Future.delayed(const Duration(seconds: 1), _updateTime);
    }
  }

  String _formatTime(DateTime dateTime) {
    final year = dateTime.year;
    final month = months[dateTime.month - 1];
    final day = dateTime.day;
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final isAM = hour < 12;
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final minuteStr = minute.toString().padLeft(2, '0');
    final period = isAM ? 'am' : 'pm';
    return '$displayHour:$minuteStr$period // $day $month $year';
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: primaryColor.withValues(alpha: 0.35), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              asciiLogo,
              textWidthBasis: TextWidthBasis.longestLine,
              style: TextStyle(
                fontFamily: 'IBM Plex Mono', 
                fontWeight: FontWeight.bold,
                color:primaryColor.withValues(alpha: 1),
                fontSize: 16,
                height: 1.3,
                letterSpacing: 0,
                leadingDistribution: TextLeadingDistribution.even,
                shadows: [
                  Shadow(
                    color: primaryColor,
                    offset: Offset.zero,
                    blurRadius: 4
                  )
                ]
              ),
            ),
            Text(
              '[ ${_formatTime(_currentTime)} ]',
              style: const TextStyle(
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
