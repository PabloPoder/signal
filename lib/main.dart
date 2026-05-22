import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signal/core/signal_terminal_screen.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    setWindowMaxSize(const Size(1024, 800));
    setWindowMinSize(const Size(1024, 800));
    setWindowTitle('SIGNAL Personal Archive System');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIGNAL Personal Archive System',
      theme: ThemeData(
        scaffoldBackgroundColor: terminalBackgroundColor,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'VT323',
            color: primaryColor.withValues(alpha: 0.72),
            fontSize: 20,
          ),
        ),
      ),
      home: const SignalTerminalScreen(),
    );
  }
}
