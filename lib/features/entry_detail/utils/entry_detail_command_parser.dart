import 'package:signal/features/entry_detail/data/entry_detail_commands.dart';
import 'package:signal/features/entry_detail/models/entry_details_command.dart';

/// Searches for a registered [EntryDetailCommand] that matches the given input.
EntryDetailCommand? findEntryDetailCommand(String command) {
  final normalized = command
      .trim()
      .toLowerCase();
      // .replaceFirst('/', '');

  for (final command in entryDetailCommands) {
    final matchesAlias = command.aliases.contains(normalized);

    if(matchesAlias) return command;
  }

  return null;
}