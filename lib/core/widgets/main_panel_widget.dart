import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:signal/core/terminal/models/parsed_command.dart';
import 'package:signal/core/terminal/parser/terminal_parser.dart';
import 'package:signal/core/terminal/responses/terminal_response.dart';
import 'package:signal/core/widgets/idle_panel_widget.dart';
import 'package:signal/core/widgets/terminal_frame.dart';
import 'package:signal/core/widgets/terminal_output.dart';
import 'package:signal/features/anomalies/widgets/anomaly_panel_widget.dart';
import 'package:signal/features/chronology/handlers/chronology_handler.dart';
import 'package:signal/features/chronology/widgets/chronology_index_panel_widget.dart';
import 'package:signal/features/entry/handlers/entry_handler.dart';
import 'package:signal/features/entry/models/entry.dart';
import 'package:signal/features/entry/widgets/entry_index_panel_widget.dart';
import 'package:signal/features/entry_detail/handlers/entry_detail_handler.dart';
import 'package:signal/features/entry_detail/widgets/entry_detail_panel_widget.dart';
import 'package:signal/features/menu/handlers/menu_handler.dart';
import 'package:signal/features/menu/models/menu_option.dart';
import 'package:signal/features/menu/widgets/menu_panel_widget.dart';
import 'package:signal/features/radar/widgets/radar_panel_widget.dart';

class MainPanelWidget extends ConsumerStatefulWidget {
  const MainPanelWidget({super.key});

  @override
  ConsumerState<MainPanelWidget> createState() => _MainPanelWidgetState();
}

class _MainPanelWidgetState extends ConsumerState<MainPanelWidget> {
  final terminalInputController =
      TextEditingController(); // Temrinal input controller

  MenuSection selectedSection = MenuSection.idle; // Menu
  Entry? selectedEntry;

  bool isSyncing = false; // Animation flag | terminal messages

  String terminalOutput = ''; // To show terminal animations

  /// Scroll controllers Focus Nodes
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

  String? _extractLastCommand(String text) {
    if (text.isEmpty || !text.endsWith('\n')) {
      return null;
    }

    final lines = text.split('\n');

    if (lines.length < 2) return null;

    final lastCommand = lines[lines.length - 2].trim().toLowerCase();

    if (lastCommand.isEmpty) return null;

    return lastCommand;
  }

  TerminalResponse? _dispatchCommand(ParsedCommand command) {
    final menuResponse = handleMenuCommands(ref, command, selectedSection);

    if (menuResponse != null) {
      return menuResponse;
    }

    switch (selectedSection) {
      case MenuSection.logEntry:
        return handleEntryCommands(ref, command, terminalInputController.text);

      case MenuSection.chronology:
        return handleChronologyCommands(ref, command);

      case MenuSection.entryDetail:
        return handleEntryDetailCommands(ref, command, selectedEntry);

      default:
        return TerminalResponse(
          success: false,
          logs: ['[FAIL] UNKNOW_COMMAND_CONTEXT'],
        );
    }
  }

  void _handleInput() {
    /// 1. ENTER DETECTION
    final rawCommand = _extractLastCommand(terminalInputController.text);

    /// 2. PARSE COMMAND
    if (rawCommand == null || isSyncing) return;
    final parsedCommand = parseCommand(rawCommand);

    /// 3. DELEGATE ACCORDING TO SECTION
    final response = _dispatchCommand(parsedCommand);

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

      selectedEntry = response.selectedEntry ?? selectedEntry;
    });

    /// 4. load inital buffer
    if (response.terminalBuffer != null) {
      terminalInputController.text = response.terminalBuffer!;
    }

    /// 5. render logs
    await _playSyncAnimation(response.logs);
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

  Future<void> _playSyncAnimation(List outputLines) async {
    if (isSyncing) return;

    setState(() {
      isSyncing = true;
    });

    for (final line in outputLines) {
      await Future.delayed(const Duration(milliseconds: 250));
      _appendSystemMessage(line);
    }

    setState(() {
      isSyncing = false;
    });
  }

  (int terminalOutputFlex, int terminalFrameFlex) get _consoleFlexDistribution {
    return switch (selectedSection) {
      MenuSection.chronology => (5, 1), // CHORNOLOGY MODE
      MenuSection.entryDetail => (5, 1), // INSPECT MODE
      MenuSection.logEntry => (2, 5), // Writing Mode
      _ => (5, 1), // DEFAULT
    };
  }

  @override
  Widget build(BuildContext context) {
    // Define terminal distribution
    final (terminalOutputFlex, terminalFrameFlex) = _consoleFlexDistribution;

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
            Expanded(
              //* MENU - RADAR *//
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
            Expanded(
              //*  INDEX - ANOMALY*//
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
            Expanded(
              //* TERMINAL_OUTPUT - TERMINA_INPUT_FRAM *//
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    flex: terminalOutputFlex,
                    child: TerminalOutput(
                      output: terminalOutput,
                      focusNode: terminalOutputFocus,
                      onExitScrollMode: () {
                        terminalInputFocus.requestFocus();
                      },
                    ),
                  ),
                  Expanded(
                    flex: terminalFrameFlex,
                    child: TerminalFrame(
                      controller: terminalInputController,
                      focusNode: terminalInputFocus,
                      onEnterScrollMode: () {
                        terminalOutputFocus.requestFocus();
                      },
                    ),
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
