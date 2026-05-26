import 'package:flutter/material.dart';
// import 'package:signal/core/audio/audio_service.dart';
import 'package:signal/core/constants/colors.dart';

class TerminalFrame extends StatefulWidget {

  final TextEditingController controller;

  const TerminalFrame({
    super.key,
    required this.controller,
  });

  @override
  State<TerminalFrame> createState() => _TerminalFrameState();
}

class _TerminalFrameState extends State<TerminalFrame> {

  // String previousText = '';

  // @override
  // void initState() {
  //   super.initState();
  //   widget.controller.addListener(
  //     _handleTypingSound,
  //   );
  // }

  // @override
  // void dispose() {
  //   widget.controller.removeListener(
  //     _handleTypingSound,
  //   );

  //   super.dispose();
  // }

  // void _handleTypingSound() {
    
  //   final current = widget.controller.text;

  //   if (
  //     current.length > previousText.length &&
  //     current.endsWith('\n')
  //   ) {

  //     AudioService.instance.play(
  //       AudioType.enter,
  //     );
  //   }

  //   // ====================
  //   // KEY PRESS
  //   // ====================

  //   else if (
  //     current.length > previousText.length
  //   ) {

  //     AudioService.instance.play(
  //       AudioType.keyPress,
  //     );
  //   }

  //   // else if (
  //   //   current.length < previousText.length
  //   // ) {

  //   //   AudioService.instance.play(
  //   //     AudioType.backspace,
  //   //   );
  //   // }

  //   previousText = current;
  // }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,

      maxLength: 500,
      maxLines: null,
      expands: true,
      autofocus: true,
      canRequestFocus: true,
      
      textAlign: TextAlign.start,
      cursorColor: primaryColor,
      cursorWidth: 10,
      cursorHeight: 22,
      
      style: TextStyle(
        color: primaryColor,
        fontFamily: 'VT323',
        fontSize: 20,
        shadows: [
          Shadow(
            blurRadius: 4,
            color: primaryColor,
            offset: Offset.zero
          )
        ]
      ),
      decoration: const InputDecoration(
        prefixText: ">",
        prefixStyle: TextStyle(
          fontFamily: 'IBMPlexMono',
          color: primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        counterText: '',
    
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        
        contentPadding: EdgeInsets.all(12),
      ),
    );
  }
}
