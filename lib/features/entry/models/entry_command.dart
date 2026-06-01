import 'package:signal/core/terminal/models/terminal_command.dart';

/// Types of commands
enum EntryCommandType {
  save,
}

/// Representation of how an Entry Command is composed.
class EntryCommand extends TerminalCommand{
  final EntryCommandType type;
  final List<String> successLogs;
  final List<String> errorLogs;

  const EntryCommand({
    required this.type,
    required super.aliases,
    required super.description,
    required this.successLogs,
    required this.errorLogs,
  });
}