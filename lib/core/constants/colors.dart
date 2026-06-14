import 'package:flutter/material.dart';

// const Color primaryColor = Color.fromARGB(246, 174, 176, 179);
// const Color primaryColor = Color(0xFF00FF80);
const Color primaryColor = Color.fromARGB(255, 40, 251, 164);
// const Color primaryColor = Color(0xFFFFBF00);
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

/// Primary Color text with glow.
TextStyle secondaryTextStyle = TextStyle(
  color: primaryColor.withValues(alpha: 0.8),
  fontFamily: 'Fixedsys62',
  fontSize: 18,
  shadows: [
    Shadow(
      color: primaryColor.withValues(alpha: 0.8),
      blurRadius: 2,
      offset: Offset.zero,
    ),
  ],
);

/// Primary color text without glow.
TextStyle tertiaryTextStyle = TextStyle(
  color: primaryColor.withValues(alpha: 0.65),
  fontFamily: 'Fixedsys62',
  fontSize: 18,
  height: 1,
);

/// Red color text with offset glow.
TextStyle headerDataTextStyle = TextStyle(
  color: warning.withValues(alpha: 1),
  fontFamily: 'Fixedsys62',
  fontSize: 18,
  shadows: [
    Shadow(
      color: warning.withValues(alpha: 1),
      blurRadius: 2,
      offset: Offset(0, 3),
    ),
  ],
);

/// Warning text (red) with glow
TextStyle warningTextStyle = TextStyle(
  color: warning.withValues(alpha: 1),
  fontFamily: 'Fixedsys62',
  fontSize: 18,
  // height: 1,
  shadows: [
    Shadow(
      color: warning.withValues(alpha: 1),
      blurRadius: 2,
      offset: Offset.zero,
    ),
  ],
);

const int maxTerminalWidth = 52;
