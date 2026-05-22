import 'dart:async';

import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';

class StatusBarWidget extends StatefulWidget {
  const StatusBarWidget({super.key});

  @override
  State<StatusBarWidget> createState() => _StatusBarWidgetState();
}

class _StatusBarWidgetState extends State<StatusBarWidget> {
  Timer? timer;

  int dotCount = 3;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(milliseconds: 500), 
      _updateDotCountState
      );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _updateDotCountState(_) {
    setState(() {
      dotCount++;

      if(dotCount > 3) {
        dotCount = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: primaryColor.withValues(alpha: 1),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Text(
          'STATUS > AWAITING TRANSMISSION${'.' * dotCount}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}