
// Colors used in the app
//


import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF00FF66);
// const Color primaryColor =  Color.fromARGB(255, 255, 145, 0);
// const Color primaryColor = Color.fromRGBO(255, 0, 25, 1);
const Color apocaliptic = Color(0xFFFFBF00);
const Color zomb = Color(0xFFFF0022);
const Color cyberpunk = Color(0xFF00FFFF);
const Color glitch = Color(0xFFFF00FF);
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