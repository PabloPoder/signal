import 'package:signal/features/entry/models/entry.dart';
import 'package:signal/features/menu/models/menu_option.dart';

/// Represents a terminal response.
class TerminalResponse {
  final bool success;
  final List<String> logs;
  final MenuSection? nextSection;

  final bool clearTerminal;
  final bool clearOutput;

  final String? terminalBuffer;
  final Entry? selectedEntry;
  final MenuSection? rebuildSection;

  const TerminalResponse({
    required this.success,
    required this.logs,
    this.nextSection,
    this.clearTerminal = true,
    this.clearOutput = false,
    this.terminalBuffer = '',
    this.selectedEntry,
    this.rebuildSection,
  });
}
