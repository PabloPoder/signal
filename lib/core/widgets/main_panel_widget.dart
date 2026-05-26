import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:signal/core/widgets/idle_panel_widget.dart';
import 'package:signal/core/widgets/terminal_frame.dart';
import 'package:signal/core/widgets/terminal_output.dart';
import 'package:signal/features/anomalies/widgets/anomaly_panel_widget.dart';
import 'package:signal/features/entry/models/entry_command.dart';
import 'package:signal/features/entry/providers/entry_provider.dart';
import 'package:signal/features/entry/utils/entry_parsers.dart';
import 'package:signal/features/entry/widgets/entry_index_panel_widget.dart';
import 'package:signal/features/menu/models/menu_option.dart';
import 'package:signal/features/menu/utils/menu_command_parser.dart';
import 'package:signal/features/menu/widgets/menu_panel_widget.dart';
import 'package:signal/features/radar/widgets/radar_panel_widget.dart';

class MainPanelWidget extends ConsumerStatefulWidget {
  const MainPanelWidget({super.key});

  @override
  ConsumerState<MainPanelWidget> createState() => _MainPanelWidgetState();
}

class _MainPanelWidgetState extends ConsumerState<MainPanelWidget> {
  
  final terminalInputController = TextEditingController(); // Temrinal input controller

  MenuSection selectedSection = MenuSection.idle; // Menu 

  bool isSyncing = false; // Animation flag | terminal messages

  String previousText = ''; // For controlling input text
  
  String terminalOutput  = ''; // To show terminal animations


  @override
  void initState() {
    super.initState();
    terminalInputController.addListener(_handleInput);
  }

  @override
  void dispose() {
    terminalInputController.removeListener(_handleInput);
    terminalInputController.dispose();
    super.dispose();
  }

  void _handleInput() {
    final text = terminalInputController.text;

    // ===================
    // ENTER DETECTION
    // ===================
    if (text.isEmpty || !text.endsWith('\n'))  {
      previousText = text;
      return;
    }

    previousText = text;
    
    if (isSyncing) return;

    // ===================
    // COMMANDS
    // ===================
    final lines = text.split('\n');

    if (lines.length < 2) return;

    // previous line from enter
    final rawText = lines[lines.length - 2].trim().toLowerCase();

    final menuOptionSelected = findMenuOptionFromCommand(rawText);

    // ===================
    // MENU SELECTION
    // ===================
    if (menuOptionSelected != null) {
      setState(() {
        selectedSection = menuOptionSelected.section;
      });

      _resetTerminal();
      _playSyncAnimation(menuOptionSelected.logs);
      return;
    }

    //===================
    // ENTRY COMMANDS
    //===================
    final entryCommandSelected = findEntryCommand(rawText);
    
    if (selectedSection == MenuSection.logEntry 
        && entryCommandSelected != null) {
      
      switch(entryCommandSelected.type) {
        case EntryCommandType.save:
          final isSaved = _saveEntry(lines);
          
          if (isSaved) {
            _resetTerminal();
            _playSyncAnimation(entryCommandSelected.successLogs);
            _resetSection();
          } else {
            _resetTerminal();
            _playSyncAnimation(entryCommandSelected.errorLogs);
          }
          break;
      }
    }
  }

  void _resetSection() {
    setState(() {
      selectedSection = MenuSection.idle;
    });
  }

  void _resetTerminal() {
    terminalOutput = '';
    terminalInputController.clear();
  }

  bool _saveEntry(List<String> lines) { 
    final entryLog = parseEntryLines(lines);
    
    if(entryLog != null){
      final (title, content) = entryLog;

      ref.read(entryProvider.notifier).createEntry(
        title: title,
        content: content,
        corruptionLevel: 0,
      );

      return true;
    }
    return false;
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
      await Future.delayed(const Duration(milliseconds: 400));
      _appendSystemMessage(line);
    }

    setState(() {
      isSyncing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  if (selectedSection == MenuSection.idle)
                    Expanded(child: IdlePanelWidget()),
                  if (selectedSection == MenuSection.logEntry)
                    Expanded(child:
                      EntryIndexPanelWidget(controller: terminalInputController)
                    ),
                  Expanded(child: AnomalyPanelWidget()),
                ],
              ),
            ),
            Expanded(
              //* ENTRY CONSOLE - SYSTEM OUTPUT *//
              flex: 2,
              child: Column(
                children: [
                  TerminalOutput(output: terminalOutput),
                  Expanded(
                    child: TerminalFrame(controller: terminalInputController),
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
