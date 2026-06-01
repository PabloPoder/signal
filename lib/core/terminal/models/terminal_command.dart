abstract class TerminalCommand {
  final List<String> aliases;
  final String description;

  const TerminalCommand({
    required this.aliases,
    required this.description,
  });
}