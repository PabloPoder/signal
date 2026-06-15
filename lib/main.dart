import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:signal/core/signal_terminal_screen.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:signal/features/entry/models/repositories/in_memory_entry_repository.dart';
import 'package:signal/features/entry/providers/entry_provider.dart';
import 'package:window_size/window_size.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repo = InMemoryEntryRepository();
  await repo.initialize();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // setWindowMaxSize(const Size(1280, 1000));
    // setWindowMinSize(const Size(1280, 1000));
    // setWindowMaxSize(const Size(1280, 720));
    // setWindowMinSize(const Size(1280, 720));
    setWindowMaxSize(const Size(1080, 800));
    setWindowMinSize(const Size(1080, 800));

    setWindowTitle('SIGNAL Personal Archive System');
  }

  runApp(
    ProviderScope(
      overrides: [entryRepositoryProvider.overrideWithValue(repo)],
      child: MyApp(),
    ),
  );
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
            fontFamily: 'Fixedsys62',
            color: primaryColor.withValues(alpha: 0.72),
            fontSize: 18,
          ),
        ),
      ),
      home: Pixelate(child: const SignalTerminalScreen()),
    );
  }
}

class Pixelate extends StatelessWidget {
  final Widget child;
  final double pixelScale;

  const Pixelate({super.key, required this.child, this.pixelScale = 2});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(devicePixelRatio: 2 / pixelScale),
      child: child,
    );
  }
}
