/// Represents a user command parsed. 
class ParsedCommand {
  final String raw;
  final String command;
  final List<String> args;

  const ParsedCommand({
    required this.raw,
    required this.command,
    required this.args,
  });

  @override
  String toString() => 'command: $command\nargs:$args';
}