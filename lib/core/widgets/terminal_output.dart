import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signal/core/constants/colors.dart';

class TerminalOutput extends StatefulWidget {
  final String output;
  final FocusNode focusNode;
  final VoidCallback? onExitScrollMode;

  const TerminalOutput({
    super.key,
    required this.output,
    required this.focusNode,
    this.onExitScrollMode,
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

  void _scrollBy(double delta) {
    if (!_scrollController.hasClients) return;

    final target = (_scrollController.offset + delta).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 80),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      child: Focus(
        focusNode: widget.focusNode,
        onKeyEvent: (node, event) {
          if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
            return KeyEventResult.ignored;
          }

          if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            _scrollBy(40);
            return KeyEventResult.handled;
          }

          if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            _scrollBy(-40);
            return KeyEventResult.handled;
          }

          if (event.logicalKey == LogicalKeyboardKey.enter ||
              event.logicalKey == LogicalKeyboardKey.tab) {
            widget.onExitScrollMode?.call();
            return KeyEventResult.handled;
          }

          return KeyEventResult.ignored;
        },
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
      ),
    );
  }
}
