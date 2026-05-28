
import 'package:signal/features/entry/data/entry_commands.dart';
import 'package:signal/features/entry/models/entry_command.dart';

/// Searches for a registered [EntryCommand] that matches the given input.
EntryCommand? findEntryCommand(String command) {
  final normalized = command
      .trim()
      .toLowerCase();
  
  for (final command in entryCommands) {
    final matchesAlias = command.aliases.contains(normalized);

    if(matchesAlias) return command;
  }

  return null;
}

(String title, String content)? parseEntryBuffer(String terminalBuffer) {
  final cleaned = terminalBuffer
      .split('\n')
      .map((line) => line.trim())
      .where((line) => 
          line.isNotEmpty &&
          !line.startsWith('/'))
      .toList();

  if (cleaned.isEmpty) return null;

  final title = cleaned.first;

  if (title.isEmpty) return null;

  final content = cleaned.length > 1
      ? cleaned.sublist(1).join('\n').trim()
      : '';

  return (title, content);
}