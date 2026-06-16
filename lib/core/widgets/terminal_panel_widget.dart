import 'package:flutter/material.dart';
import 'package:signal/core/widgets/terminal_input.dart';
import 'package:signal/core/widgets/terminal_output.dart';

class TerminalPanelWidget extends StatelessWidget {
  final String output;
  final FocusNode outputFocus;
  final TextEditingController terminalInputController;
  final FocusNode inputFocus;
  final int outputFlex;
  final int inputFlex;
  final VoidCallback? onEnterScrollMode;
  final VoidCallback? onEnterTypingMode;

  const TerminalPanelWidget({
    super.key,
    required this.output,
    required this.outputFocus,
    required this.terminalInputController,
    required this.inputFocus,
    required this.outputFlex,
    required this.inputFlex,
    required this.onEnterScrollMode,
    required this.onEnterTypingMode,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      //* TERMINAL_OUTPUT - TERMINA_INPUT_FRAM *//
      flex: 2,
      child: Column(
        children: [
          Expanded(
            flex: outputFlex,
            child: TerminalOutput(
              output: output,
              focusNode: outputFocus,
              onExitScrollMode: onEnterTypingMode,
            ),
          ),
          Expanded(
            flex: inputFlex,
            child: TerminalInput(
              controller: terminalInputController,
              focusNode: inputFocus,
              onEnterScrollMode: onEnterScrollMode,
            ),
          ),
        ],
      ),
    );
  }
}
