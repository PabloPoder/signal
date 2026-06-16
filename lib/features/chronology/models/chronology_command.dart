import 'package:signal/core/terminal/models/terminal_command.dart';

/// Types of commands
enum ChronologyCommandType {
  inspect, // Read
  //TODO:
  //select,
  //find,
  //filter,
}

/// Representation of how a Chronology Command is composed.
class ChronologyCommand extends TerminalCommand {
  final ChronologyCommandType type;
  final List<String> successLogs;
  final List<String> errorLogs;

  const ChronologyCommand({
    required this.type,
    required super.aliases,
    required super.description,
    required this.successLogs,
    required this.errorLogs,
  });
}
