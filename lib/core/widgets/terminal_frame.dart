import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: BoxBorder.fromLTRB(
          top: BorderSide(width: 1.5, color: primaryColor.withValues(alpha: 0.35)),
        ),
      ),
      child: TextField(
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
        decoration:  InputDecoration(
          prefixText: ">",
          // prefix: Text(">"),
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
      ),
    );
  }
}
