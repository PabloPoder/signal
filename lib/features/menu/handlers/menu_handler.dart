import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/core/constants/about_ascii.dart';
import 'package:signal/core/constants/colors.dart';
import 'package:signal/core/terminal/models/terminal_command.dart';
import 'package:signal/core/terminal/models/parsed_command.dart';
import 'package:signal/core/terminal/responses/terminal_response.dart';
import 'package:signal/features/chronology/data/chronology_commands.dart';
import 'package:signal/features/chronology/data/chronology_logs.dart';
import 'package:signal/features/entry/data/entry_commands.dart';
import 'package:signal/features/entry/models/entry.dart';
import 'package:signal/features/entry/providers/entry_provider.dart';
import 'package:signal/features/entry/utils/template.dart';
import 'package:signal/features/entry_detail/data/entry_detail_commands.dart';
import 'package:signal/features/menu/data/menu_options.dart';
import 'package:signal/features/menu/models/menu_option.dart';
import 'package:signal/features/menu/utils/menu_command_parser.dart';

TerminalResponse? handleMenuCommands(
  WidgetRef ref,
  ParsedCommand command,
  MenuSection selectedSection,
) {
  /// GLOBAL COMMANDS
  if (command.command.trim().toLowerCase() == '/help') {
    return _buildHelpResponse(selectedSection);
  }

  if (command.command.trim().toLowerCase() == '/clear') {
    return _buildClearResponse(selectedSection);
  }

  if (command.command.trim().toLowerCase() == '/about') {
    return _buildAboutResponse(selectedSection);
  }

  /// NAVIGATION
  final menuOptionSelected = findMenuOptionFromCommand(command.command);

  if (menuOptionSelected == null) return null;

  /// SPECIAL SECTION BOOT LOGIC
  if (menuOptionSelected.section == MenuSection.logEntry) {
    return TerminalResponse(
      success: true,
      logs: menuOptionSelected.logs,
      nextSection: menuOptionSelected.section,
      clearOutput: true,
      clearTerminal: true,
      terminalBuffer: entryLogTemplate,
    );  
  }

  if (menuOptionSelected.section == MenuSection.chronology) {
    return buildChronologyResponse(
      ref,
      mountLogs: menuOptionSelected.logs,
    );
  }

  return TerminalResponse(
    success: true,
    logs: menuOptionSelected.logs,
    nextSection: menuOptionSelected.section,
    clearOutput: true,
    clearTerminal: true,
  );
}

/// INTERNAL ACTIONS
/// 
TerminalResponse _buildHelpResponse(MenuSection currentSection) {
  List<TerminalCommand> commands = []; 

  switch(currentSection) {
    case MenuSection.logEntry:
      commands = entryCommands;
      break;

    case MenuSection.entryDetail:
      commands = entryDetailCommands;
      break;
    
    case MenuSection.chronology:
      commands = chronologyCommands;
      break;

    case MenuSection.idle:
      commands = [
        ...entryCommands,
        ...entryDetailCommands,
        ...chronologyCommands
      ];
      break;

    case MenuSection.archive:
      break;

    case MenuSection.system:
      break;
  }

  final logs = [
    '',
    'COMMAND_INDEX',
    '-' * maxTerminalWidth,
    ..._buildCommandsLogs(commands),
  ];

  return TerminalResponse(
    success: true,
    logs: logs,
  );
}


TerminalResponse _buildClearResponse(MenuSection currentSection) {
  return TerminalResponse(
    success: true,
    logs: [],
    clearOutput: true,
    clearTerminal: true,
  );
}

TerminalResponse _buildAboutResponse(MenuSection currentSection) {
  return TerminalResponse(
    success: true,
    logs: [aboutAscii],
    clearOutput: true,
    clearTerminal: true,
  );
}


TerminalResponse buildChronologyResponse(
  WidgetRef ref, {
  List<String> mountLogs = const[],
}) {
  final entries = ref.read(entryProvider);

  if (entries.isEmpty) {
    return TerminalResponse(
      success: true,
      logs: [
        ...mountLogs,
        '',
        ...chronologyEmptyLogs,
      ],
      nextSection: MenuSection.chronology,
      clearOutput: true,
      clearTerminal: true,
    );
  }

  final logs = [
    ...mountLogs,
    '',
    ...chronologyHeaderLogs,
    ..._buildChronologyEntryLogs(entries),
    // ...chronologyFooterLogs, '-----'
  ];

  return TerminalResponse(
    success: true,
    logs: logs,
    nextSection: MenuSection.chronology,
    clearOutput: true,

    clearTerminal: true,
  );
}

List<String> _buildCommandsLogs(List<TerminalCommand> commands) {
  final List<String> logs = [];
  
  for (final menuOption in menuOptions) {
    final aliases = menuOption.aliases.join(' • ');

    logs.add('[NAV] ${menuOption.label} • $aliases');
    logs.add('  └─> Mounts localized system sector.');
  }

  logs.add('');

  for (final cmd in commands) {
    final aliases = cmd.aliases.join(' • ');

    logs.add('[CMD] $aliases');
    logs.add('  └─> ${cmd.description}');
  }

  return logs;
}

List<String> _buildChronologyEntryLogs(List<Entry> entries) {
  final List<String> chronologyLogs = [];

  for (int i = 0; i < entries.length; i++) {
    chronologyLogs.add(
      _formatChronologyEntry(i, entries[i]),
    );
  }

  return chronologyLogs;
}

String _formatChronologyEntry(int index, Entry entry) {
  final String idStr = (index + 1)
      .toString()
      .padLeft(2, '0');

  final String nodeDate =
      '${entry.createdAt.year}.'
      '${entry.createdAt.month.toString().padLeft(2, '0')}.'
      '${entry.createdAt.day.toString().padLeft(2, '0')}';

  String titleStr = entry.title.toUpperCase();

  final finalLine = '> [$idStr] · $nodeDate · $titleStr';

  if (finalLine.length > maxTerminalWidth) {
    return '${'> [$idStr] · $nodeDate · $titleStr'.substring(0, maxTerminalWidth -3)}...';
  }

  return finalLine;
}