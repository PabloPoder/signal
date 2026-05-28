import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/core/terminal/models/parsed_command.dart';
import 'package:signal/core/terminal/responses/terminal_response.dart';
import 'package:signal/core/utils/date_parser.dart';
import 'package:signal/features/chronology/models/chronology_command.dart';
import 'package:signal/features/chronology/utils/chronology_command_parser.dart';
import 'package:signal/features/entry/providers/entry_provider.dart';
import 'package:signal/features/menu/models/menu_option.dart';

TerminalResponse? handleChronologyCommands(WidgetRef ref, ParsedCommand command) {
  final chronologyCommand = findChronologyCommand(command.command);

  if (chronologyCommand == null) return null;

  switch (chronologyCommand.type) {
    case ChronologyCommandType.inspect:
      return _buildInspectResponse(ref, command);
    case ChronologyCommandType.filter:
      return TerminalResponse(success: true, logs: []);
    case ChronologyCommandType.find:
      return TerminalResponse(success: true, logs: []);
    case ChronologyCommandType.select:
      return TerminalResponse(success: true, logs: []);
  }
}


TerminalResponse _buildInspectResponse(
  WidgetRef ref, 
  ParsedCommand command, 
) {
  
  final id = int.tryParse(
    command.args.firstOrNull ?? '',
  );

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

  final rawTelemetry = entry.corruptionLevel < 6 
      ? 'DECRYPTED'
      : 'CRYPTED';

  return TerminalResponse(
    success: true,
    logs: [
      '[${entry.id}] DATA_BUFFER_STREAM',
      '--------------------------------------------------',
      'TITLE: ${entry.title}',
      'DATE: ${formatTime(entry.createdAt)}',
      'NODE_ID: ARG-01_CHORNO_N${entry.id}',
      'RAW_TELEMETRY: [ $rawTelemetry ]',
      '--------------------------------------------------',
      entry.content,
    ],
    nextSection: MenuSection.entryDetail,
    selectedEntry: entry,
    clearOutput: true,
    clearTerminal: true,
  );
}