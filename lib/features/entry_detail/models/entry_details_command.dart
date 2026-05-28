enum EntryDetailCommandType {
  patch,    // Edit
  delete,   // Delete
  decode,   // Fix
  back,
}

/// Representation of how a EntryDetailCommand is composed.
class EntryDetailCommand {
  final EntryDetailCommandType type;
  final List<String> aliases;
  final List<String> successLogs;
  final List<String> errorLogs;

  const EntryDetailCommand({
    required this.type,
    required this.aliases,
    required this.successLogs,
    required this.errorLogs,
  });
}