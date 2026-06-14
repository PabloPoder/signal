import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';

class HeaderMetadataWidget extends StatefulWidget {
  const HeaderMetadataWidget({super.key});

  static int randomPort = Random().nextInt(3000);
  static int randomSector = Random().nextInt(5);

  static const sectors = ['EAST', 'WEST', 'NORTH', 'SOUTH', 'UNKNOW'];

  @override
  State<HeaderMetadataWidget> createState() => _HeaderMetadataWidgetState();
}

class _HeaderMetadataWidgetState extends State<HeaderMetadataWidget> {
  String nodeText = "NODE: ARG-01";
  final List<String> glitchChars = ['%', '&', r'$', '#', '@', '?', 'X', '0'];
  final Random _random = Random();

  Timer? _glitchTimer;
  Timer? _resetTimer;

  void _scheduleNextGlitch() {
    _glitchTimer?.cancel();

    final int nextGlitchInSeconds = 10 + _random.nextInt(16);

    _glitchTimer = Timer(Duration(seconds: nextGlitchInSeconds), () {
      if (!mounted) return;

      setState(() {
        final String randomChar =
            glitchChars[_random.nextInt(glitchChars.length)];
        nodeText = "NODE: A${randomChar}G-01";
      });

      _resetTimer?.cancel();
      _resetTimer = Timer(const Duration(milliseconds: 120), () {
        if (!mounted) return;

        setState(() {
          nodeText = "NODE: ARG-01";
        });

        _scheduleNextGlitch();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _scheduleNextGlitch();
  }

  @override
  void dispose() {
    _glitchTimer?.cancel();
    _resetTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(nodeText, style: headerDataTextStyle),
          Text(
            "SECTOR: ${HeaderMetadataWidget.sectors[HeaderMetadataWidget.randomSector]}",
            style: headerDataTextStyle,
          ),
          Text("STATUS: STABLE", style: headerDataTextStyle),
          Text(
            "PORT.....${HeaderMetadataWidget.randomPort}",
            style: headerDataTextStyle,
          ),
        ],
      ),
    );
  }
}
