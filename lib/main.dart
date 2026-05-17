import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIGNAL Personal Archive System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Hello, SIGNAL Personal Archive System!'),
        ),
      ),
    );
  }
}