import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/core/terminal/models/parsed_command.dart';
import 'package:signal/core/terminal/responses/terminal_response.dart';
import 'package:signal/features/entry/models/entry_command.dart';
import 'package:signal/features/entry/providers/entry_provider.dart';
import 'package:signal/features/entry/utils/entry_parsers.dart';
import 'package:signal/features/entry/utils/template.dart';
import 'package:signal/features/menu/models/menu_option.dart';

TerminalResponse? handleEntryCommands(
  WidgetRef ref,
  ParsedCommand command,
  String terminalBuffer,
) {
  final entryCommandSelected = findEntryCommand(command.command);

  if (entryCommandSelected == null) return null;

  switch (entryCommandSelected.type) {
    case EntryCommandType.save:
      final isSaved = _saveEntry(ref, terminalBuffer);
      final logs = isSaved
          ? entryCommandSelected.successLogs
          : entryCommandSelected.errorLogs;

      return TerminalResponse(
        success: isSaved,
        logs: logs,
        nextSection: MenuSection.idle,
        clearOutput: true,
        clearTerminal: true,
      );
  }
}

/// INTERNAL ACTIONS
bool _saveEntry(WidgetRef ref, String terminalBuffer) {
  final entryLog = parseEntryBuffer(terminalBuffer);

  if (entryLog == null) return false;

  final (title, content) = entryLog;

  final template = parseEntryBuffer(entryLogTemplate)!;
  final (templateTitle, _) = template;

  if (title == templateTitle) {
    return false;
  }

  ref.read(entryProvider.notifier).createEntry(title: title, content: content);

  return true;
}
