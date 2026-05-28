import 'package:signal/features/chronology/data/chronology_commands.dart';
import 'package:signal/features/chronology/models/chronology_command.dart';

/// Searches for a registered [ChronologyCommand] that matches the given input.
ChronologyCommand? findChronologyCommand(String command) {
  final normalized = command
      .trim()
      .toLowerCase();
      // .replaceFirst('/', '');

  for (final command in chronologyCommands) {
    final matchesAlias = command.aliases.contains(normalized);

    if(matchesAlias) return command;
  }

  return null;
}