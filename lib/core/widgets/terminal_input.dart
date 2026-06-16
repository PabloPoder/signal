import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signal/core/constants/app_limits.dart';
import 'package:signal/core/constants/colors.dart';

class TerminalInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback? onEnterScrollMode;

  const TerminalInput({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onEnterScrollMode,
  });

  @override
  State<TerminalInput> createState() => _TerminalInputState();
}

class _TerminalInputState extends State<TerminalInput> {
  static const _readModeText =
      '[!] STATUS :: READ_MODE :: ↑↓ SEEK :: ENTER RESUME';

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }

  void _onFocusChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final hasFocus = widget.focusNode.hasFocus;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1.5,
            color: primaryColor.withValues(alpha: 0.35),
          ),
        ),
      ),
      child: Focus(
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.escape) {
            widget.onEnterScrollMode?.call();
            return KeyEventResult.handled;
          }

          return KeyEventResult.ignored;
        },
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,

          readOnly: !hasFocus,
          showCursor: hasFocus,

          maxLength: maxEntryChars,
          maxLines: null,
          expands: true,

          textAlign: TextAlign.start,
          cursorColor: primaryColor,
          cursorWidth: 10,
          cursorHeight: 22,

          style: secondaryTextStyle,

          decoration: InputDecoration(
            prefixText: hasFocus ? '>' : '',
            hintText: hasFocus ? null : _readModeText,
            hintStyle: secondaryTextStyle,

            counterText: '',
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ),
    );
  }
}
