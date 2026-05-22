import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class CRTDistortion extends StatefulWidget {
  final Widget child;

  const CRTDistortion({
    super.key,
    required this.child,
  });

  @override
  State<CRTDistortion> createState() => _CRTDistortionState();
}

class _CRTDistortionState extends State<CRTDistortion> {
  ui.FragmentShader? shader;

  @override
  void initState() {
    super.initState();
    loadShader();
  }

  Future<void> loadShader() async {
    final program = await ui.FragmentProgram.fromAsset(
      'assets/shaders/crt.frag',
    );

    shader = program.fragmentShader();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (shader == null) {
      return widget.child;
    }

    return AnimatedSampler(
      (image, size, canvas) {
        shader!
          ..setFloat(0, size.width)
          ..setFloat(1, size.height)
          ..setImageSampler(0, image);

        canvas.drawRect(
          Offset.zero & size,
          Paint()..shader = shader,
        );
      },
      child: widget.child,
    );
  }
}