import 'package:signal/features/entry/data/entry_commands.dart';
import 'package:signal/features/entry/models/entry_command.dart';

/// Returns the registered [EntryCommand] whose alias matches [command].
///
/// The input is normalized (trimmed and lowercased) before comparison.
/// Returns `null` if no matching command is found.
EntryCommand? findEntryCommand(String command) {
  final normalized = command.trim().toLowerCase();

  for (final command in entryCommands) {
    final matchesAlias = command.aliases.contains(normalized);

    if (matchesAlias) return command;
  }

  return null;
}

/// Extracts an entry title and content from a terminal buffer.
///
/// The first line is treated as the title and the last line as
/// a terminal command. Returns `null` if the entry is invalid.
(String title, String content)? parseEntryBuffer(String terminalBuffer) {
  final separatedText = terminalBuffer.split('\n').toList();

  /// Remove trailing empty lines after `/sync`.
  while (separatedText.isNotEmpty && separatedText.last.trim().isEmpty) {
    separatedText.removeLast();
  }

  if (separatedText.isEmpty) return null;

  final title = separatedText.first.trim();

  /// All the lines but the first (title) and the last (command /sync)
  final bodyLines = separatedText.length > 2
      ? separatedText.sublist(1, separatedText.length - 1)
      : <String>[];

  final content = bodyLines.join('\n');

  if (title.isEmpty || content.isEmpty) return null;

  return (title, content);
}
