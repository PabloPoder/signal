import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/core/terminal/models/parsed_command.dart';
import 'package:signal/core/terminal/responses/terminal_response.dart';
import 'package:signal/features/chronology/handlers/chronology_handler.dart';
import 'package:signal/features/entry/handlers/entry_handler.dart';
import 'package:signal/features/entry/models/entry.dart';
import 'package:signal/features/entry_detail/handlers/entry_detail_handler.dart';
import 'package:signal/features/menu/handlers/menu_handler.dart';
import 'package:signal/features/menu/models/menu_option.dart';

class CommandDispatcher {
  static TerminalResponse? dispatch({
    required WidgetRef ref,
    required ParsedCommand command,
    required MenuSection section,
    required Entry? selectedEntry,
    required String terminalBuffer,
  }) {
    final menuResponse = handleMenuCommands(ref, command, section);

    if (menuResponse != null) {
      return menuResponse;
    }

    switch (section) {
      case MenuSection.logEntry:
        return handleEntryCommands(ref, command, terminalBuffer);

      case MenuSection.chronology:
        return handleChronologyCommands(ref, command);

      case MenuSection.entryDetail:
        return handleEntryDetailCommands(ref, command, selectedEntry);

      default:
        return TerminalResponse(
          success: false,
          logs: ['[FAIL] UNKNOW_COMMAND_CONTEXT'],
        );
    }
  }
}
