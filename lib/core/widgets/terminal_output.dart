import 'package:flutter/material.dart';
import 'package:signal/core/constants/colors.dart';

class TerminalOutput extends StatefulWidget {

  final String output;
  
  const TerminalOutput({
    super.key,
    required this.output,
    });

  @override
  State<TerminalOutput> createState() => _TerminalOutputState();
}

class _TerminalOutputState extends State<TerminalOutput> {

  final ScrollController _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant TerminalOutput oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.output != oldWidget.output) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), 
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      child: ListView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          Text(
            widget.output,
            style: TextStyle(
              color: primaryColor.withValues(alpha: 0.8),
              shadows: [
                Shadow(
                  color: primaryColor.withValues(alpha: 0.8),
                  blurRadius: 2,
                  offset: Offset.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
