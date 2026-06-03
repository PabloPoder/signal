import 'package:flutter/material.dart';

// const Color primaryColor = Color(0xFFE6F1FF);
// const Color primaryColor = Color(0xFF00FF80);
const Color primaryColor = Color.fromARGB(255, 40, 251, 164);
// const Color primaryColor = Color(0xFFFF0022);
const Color apocaliptic = Color(0xFFFFBF00);
const Color warning = Color.fromARGB(255, 255, 0, 0);
const Color zomb = Color(0xFFFF0022);
const Color cyberpunk = Color(0xFF00F0FF);
const Color glitch = Color(0xFFFF007C);
const Color matrixGreen = Color(0xFF00FF00);
const Color terminalBackgroundColor = Color.fromARGB(255, 0, 0, 0);

ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  scaffoldBackgroundColor: terminalBackgroundColor,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: primaryColor),
    bodyLarge: TextStyle(color: primaryColor),
    bodySmall: TextStyle(color: primaryColor),
  ),
);

TextStyle secondaryTextStyle = TextStyle(
  color: primaryColor.withValues(alpha: 0.8),
  shadows: [
    Shadow(
      color: primaryColor.withValues(alpha: 0.8),
      blurRadius: 2,
      offset: Offset.zero,
    ),
  ],
);

TextStyle tertiaryTextStyle = TextStyle(
  color: primaryColor.withValues(alpha: 0.65),
  height: 1,
);

TextStyle warningTextStyle = TextStyle(
  color: warning.withValues(alpha: 1),
  shadows: [
    Shadow(
      color: warning.withValues(alpha: 1),
      blurRadius: 2,
      offset: Offset(0, 3),
    ),
  ],
);

const int maxTerminalWidth = 52;
