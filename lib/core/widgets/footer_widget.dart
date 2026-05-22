import 'dart:async';

import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({super.key});

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {

  static const freqStates = ["FREQ: 128.31GHz", "FREQ: 128.39GHz", "FREQ: 128.34GHz"];
  static const gainStates = ["GAIN: 24.9dB", "GAIN: 24.1dB", "GAIN: 24.5dB"];
  static const sysmemStates = ["SYS_MEM: 84%", "SYS_MEM: 82%", "SYS_MEM: 86%"];

  Timer? timer;

  int frame = 0;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(milliseconds: 500), 
      _updateFrameState
      );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _updateFrameState(_) {
    setState(() {
      frame = (frame + 1) % 3;
    });
  }


  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: primaryColor.withValues(alpha: 0.35), width: 1.5),
          left:  BorderSide(color: primaryColor.withValues(alpha: 0.35), width: 1.5),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            _FooterItem(info: freqStates[frame]),
            _FooterItem(info: gainStates[frame]),
            _FooterItem(info: sysmemStates[frame]),
            _FooterItem(info: "BUF: STABLE"),
          ],
        ),
      ),
    );
  }
}

class _FooterItem extends StatelessWidget {
  final String info;

  const _FooterItem({
    required this.info
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: primaryColor.withValues(alpha: 0.35), width: 1.5),
          ),
        ),
        child: Center(
          child: Text(info),
        ),
      ),
    );
  }
}
