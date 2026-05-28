import 'package:signal/core/terminal/models/parsed_command.dart';

/// Parses the [rawText] into a [ParsedCommand].
///
/// Extracts the first word as the command (converted to lowercase)
/// and treats the remaining words as [args].
///
/// Returns a new [ParsedCommand] instance containing the raw input,
/// the parsed command, and the argument list.
ParsedCommand parseCommand(String rawText) {

  final parts = rawText
      .trim()
      .split(' ')
      .where((part) => part.isNotEmpty)
      .toList();

  if (parts.isEmpty) {
    return ParsedCommand(
      raw: rawText,
      command: '',
      args: [],
    );
  }

  final command = parts.first.toLowerCase();

  final args = parts.skip(1).toList();

  return ParsedCommand(
    raw: rawText, 
    command: command, 
    args: args,
  );
}