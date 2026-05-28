import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:signal/core/utils/date_parser.dart';

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
              '[ ${formatTimeWithHour(_currentTime)} ]',
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
