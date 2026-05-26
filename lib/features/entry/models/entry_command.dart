enum EntryCommandType {
  save,
}

class EntryCommand {
  final EntryCommandType type;
  final List<String> aliases;
  final List<String> successLogs;
  final List<String> errorLogs;

  const EntryCommand({
    required this.type,
    required this.aliases,
    required this.successLogs,
    required this.errorLogs,
  });
}