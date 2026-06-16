import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:signal/core/constants/colors.dart';
import 'package:signal/core/terminal/parser/terminal_parser.dart';
import 'package:signal/core/terminal/responses/terminal_response.dart';
import 'package:signal/core/terminal/services/command_dispatcher.dart';
import 'package:signal/core/terminal/services/terminal_output_service.dart';
import 'package:signal/core/utils/menu_section_layout.dart';
import 'package:signal/core/utils/terminal_buffer.dart';
import 'package:signal/core/widgets/idle_panel_widget.dart';
import 'package:signal/core/widgets/terminal_panel_widget.dart';

import 'package:signal/features/anomalies/widgets/anomaly_panel_widget.dart';
import 'package:signal/features/chronology/widgets/chronology_index_panel_widget.dart';

import 'package:signal/features/entry/widgets/entry_index_panel_widget.dart';
import 'package:signal/features/entry/models/entry.dart';
import 'package:signal/features/entry_detail/widgets/entry_detail_panel_widget.dart';
import 'package:signal/features/menu/models/menu_option.dart';
import 'package:signal/features/menu/widgets/menu_panel_widget.dart';
import 'package:signal/features/radar/widgets/radar_panel_widget.dart';

class MainPanelWidget extends ConsumerStatefulWidget {
  const MainPanelWidget({super.key});

  @override
  ConsumerState<MainPanelWidget> createState() => _MainPanelWidgetState();
}

class _MainPanelWidgetState extends ConsumerState<MainPanelWidget> {
  MenuSection selectedSection = MenuSection.idle;
  Entry? selectedEntry;

  final terminalInputController = TextEditingController();

  /// flag for mounting logs into the output
  bool isSyncing = false;

  String terminalOutput = '';

  /// Controlling the focus, input -> typing mode, reading mode.
  final terminalInputFocus = FocusNode();
  final terminalOutputFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    terminalInputController.addListener(_handleInput);
  }

  @override
  void dispose() {
    terminalInputController.removeListener(_handleInput);
    terminalInputController.dispose();

    terminalInputFocus.dispose();
    terminalOutputFocus.dispose();

    super.dispose();
  }

  void _handleInput() {
    /// 1. ENTER DETECTION
    final rawCommand = extractLastCommand(terminalInputController.text);

    /// 2. PARSE COMMAND
    if (rawCommand == null || isSyncing) return;
    final parsedCommand = parseCommand(rawCommand);

    /// 3. DELEGATE ACCORDING TO SECTION
    final response = CommandDispatcher.dispatch(
      ref: ref,
      command: parsedCommand,
      section: selectedSection,
      selectedEntry: selectedEntry,
      terminalBuffer: terminalInputController.text,
    );

    /// 4. RECEIVE TERMINAL RESPONSE
    if (response != null) {
      _renderResponse(response);
    }
  }

  Future<void> _renderResponse(TerminalResponse response) async {
    /// 1. clear terminal input
    if (response.clearTerminal) {
      terminalInputController.clear();
    }

    /// 2. clear output buffer
    if (response.clearOutput) {
      setState(() {
        terminalOutput = '';
      });
    }

    /// 3. update section
    setState(() {
      selectedSection = response.nextSection ?? selectedSection;

      // Enter scroll mode if not "/new entry"
      if (selectedSection != MenuSection.logEntry) {
        _enterScrollMode();
      }

      selectedEntry = response.selectedEntry ?? selectedEntry;
    });

    /// 4. load inital buffer
    if (response.terminalBuffer != null) {
      terminalInputController.text = response.terminalBuffer!;
    }

    /// 5. render logs
    await _playSyncAnimation(response.logs);
  }

  /// This method clears the terminalInput and change to ScrollMode
  void _enterScrollMode() {
    terminalInputController.clear();
    terminalOutputFocus.requestFocus();
  }

  void _appendSystemMessage(String text) {
    setState(() {
      if (terminalOutput.isEmpty) {
        terminalOutput = text;
      } else {
        terminalOutput += '\n$text';
      }
    });
  }

  Future<void> _playSyncAnimation(List<String> outputLines) async {
    if (isSyncing) return;

    setState(() {
      isSyncing = true;
    });

    await TerminalOutputService.appendLogs(
      lines: outputLines,
      delay: const Duration(milliseconds: 250),
      onLine: _appendSystemMessage,
    );

    setState(() {
      isSyncing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define terminal distribution
    final (terminalOutputFlex, terminalInputFlex) =
        selectedSection.consoleDistribution;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            //* MENU - RADAR *//
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: MenuPanelWidget(selectedSection: selectedSection),
                  ),
                  Expanded(child: RadarPanelWidget()),
                ],
              ),
            ),
            //*  INDEX - ANOMALY *//
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: switch (selectedSection) {
                      MenuSection.idle => IdlePanelWidget(),
                      MenuSection.logEntry => EntryIndexPanelWidget(
                        controller: terminalInputController,
                      ),
                      MenuSection.chronology => ChronologyIndexPanelWideg(),
                      MenuSection.entryDetail => EntryDeatilPanelWidget(
                        entry: selectedEntry!,
                      ),
                      _ => IdlePanelWidget(),
                    },
                  ),
                  Expanded(child: AnomalyPanelWidget()),
                ],
              ),
            ),
            TerminalPanelWidget(
              output: terminalOutput,
              outputFocus: terminalOutputFocus,
              terminalInputController: terminalInputController,
              inputFocus: terminalInputFocus,
              outputFlex: terminalOutputFlex,
              inputFlex: terminalInputFlex,
              onEnterScrollMode: _enterScrollMode,
              onEnterTypingMode: () => {terminalInputFocus.requestFocus()},
            ),
          ],
        ),
      ),
    );
  }
}
