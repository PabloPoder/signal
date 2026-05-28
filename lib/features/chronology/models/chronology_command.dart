/// Types of commands
enum ChronologyCommandType {
  inspect,  // Read
  select,
  find,
  filter
}

/// Representation of how a Chronology Command is composed.
class ChronologyCommand {
  final ChronologyCommandType type;
  final List<String> aliases;
  final List<String> successLogs;
  final List<String> errorLogs;

  const ChronologyCommand({
    required this.type,
    required this.aliases,
    required this.successLogs,
    required this.errorLogs,
  });
}
