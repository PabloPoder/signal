import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/core/terminal/models/parsed_command.dart';
import 'package:signal/core/terminal/responses/terminal_response.dart';
import 'package:signal/features/chronology/models/chronology_command.dart';
import 'package:signal/features/chronology/utils/chronology_command_parser.dart';
import 'package:signal/features/entry/providers/entry_provider.dart';
import 'package:signal/features/entry/utils/entry_response_builder.dart';

TerminalResponse? handleChronologyCommands(
  WidgetRef ref,
  ParsedCommand command,
) {
  final chronologyCommand = findChronologyCommand(command.command);

  if (chronologyCommand == null) {
    return TerminalResponse(
      success: false,
      logs: ['[FAIL] UNKNOW_COMMAND_CONTEXT'],
    );
  }

  switch (chronologyCommand.type) {
    case ChronologyCommandType.inspect:
      return buildInspectResponse(ref, command);

    // case ChronologyCommandType.back:
    //   return TerminalResponse(
    //     success: true,
    //     nextSection: MenuSection.idle,
    //     logs: [],
    //     clearOutput: true,
    //     clearTerminal: true,
    //   );
  }
}

TerminalResponse buildInspectResponse(WidgetRef ref, ParsedCommand command) {
  final id = int.tryParse(command.args.firstOrNull ?? '');

  final errorResponse = TerminalResponse(
    success: false,
    logs: ['[FAIL] UNKNOW_ENTRY_INDEX'],
    clearOutput: false,
    clearTerminal: true,
  );

  if (id == null) return errorResponse;

  final entries = ref.read(entryProvider);

  if (id < 1 || id > entries.length) {
    return TerminalResponse(
      success: false,
      logs: ['[FAIL] UNKNOW_ENTRY_INDEX'],
      clearOutput: false,
      clearTerminal: true,
    );
  }

  final entry = entries[id - 1];

  return buildEntryDetailResponse(entry);
}
