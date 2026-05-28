import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/core/terminal/models/parsed_command.dart';
import 'package:signal/core/terminal/responses/terminal_response.dart';
import 'package:signal/features/chronology/data/chronology_logs.dart';
import 'package:signal/features/entry/models/entry.dart';
import 'package:signal/features/entry/providers/entry_provider.dart';
import 'package:signal/features/menu/models/menu_option.dart';
import 'package:signal/features/menu/utils/menu_command_parser.dart';

TerminalResponse? handleMenuCommands(WidgetRef ref, ParsedCommand command) {
  final menuOptionSelected = findMenuOptionFromCommand(command.command);

  if (menuOptionSelected == null) return null;

  /// special section boot logic
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

/// Internal actions

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
    ...chronologyFooterLogs,
  ];

  return TerminalResponse(
    success: true,
    logs: logs,
    nextSection: MenuSection.chronology,
    clearOutput: true,
    clearTerminal: true,
  );
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

  if (titleStr.length > 25) {
    titleStr = '${titleStr.substring(0, 22)}...';
  }

  return '> [$idStr] | $nodeDate | $titleStr';
}