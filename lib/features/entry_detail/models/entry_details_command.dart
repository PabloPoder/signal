import 'package:signal/core/terminal/models/terminal_command.dart';

enum EntryDetailCommandType {
  annotate, // CreateAnnotation
  delete, // Delete
  decode, // Fix
}

/// Representation of how a EntryDetailCommand is composed.
class EntryDetailCommand extends TerminalCommand {
  final EntryDetailCommandType type;
  final List<String> successLogs;
  final List<String> errorLogs;

  const EntryDetailCommand({
    required this.type,
    required super.aliases,
    required super.description,
    required this.successLogs,
    required this.errorLogs,
  });
}
