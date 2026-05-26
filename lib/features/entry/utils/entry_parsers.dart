
import 'package:signal/features/entry/data/entry_commands.dart';
import 'package:signal/features/entry/models/entry_command.dart';

EntryCommand? findEntryCommand(String command) {
  final normalized = command
      .trim()
      .toLowerCase();
  
  for (final entryCommand in entryCommands) {
    final matchesAlias = entryCommand.aliases.contains(normalized);

    if(matchesAlias) return entryCommand;
  }

  return null;
}

(String title, String content)? parseEntryLines(List<String> lines) {
  final cleaned = lines.where((l) => l.trim().isNotEmpty).toList();

  cleaned.removeLast(); // remove commmand

  if (cleaned.isEmpty) return null;

  final title = cleaned.first.trim();
  final content = cleaned.length > 1
      ? cleaned.sublist(1).join('\n').trim()
      : '';

  return (title, content);
}