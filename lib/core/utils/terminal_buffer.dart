String? extractLastCommand(String text) {
  if (text.isEmpty || !text.endsWith('\n')) {
    return null;
  }

  final lines = text.split('\n');

  if (lines.length < 2) return null;

  final lastCommand = lines[lines.length - 2].trim().toLowerCase();

  if (lastCommand.isEmpty) return null;

  return lastCommand;
}
