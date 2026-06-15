import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/core/terminal/models/parsed_command.dart';
import 'package:signal/core/terminal/responses/terminal_response.dart';
import 'package:signal/features/entry/models/entry.dart';
import 'package:signal/features/entry/providers/entry_provider.dart';
import 'package:signal/features/entry/utils/annotation_parser.dart';
import 'package:signal/features/entry/utils/entry_response_builder.dart';
import 'package:signal/features/entry_detail/models/entry_details_command.dart';
import 'package:signal/features/entry_detail/services/recovery_entry.dart';
import 'package:signal/features/entry_detail/utils/entry_detail_command_parser.dart';
import 'package:signal/features/menu/handlers/menu_handler.dart';
import 'package:signal/features/menu/models/menu_option.dart';

TerminalResponse? handleEntryDetailCommands(
  WidgetRef ref,
  ParsedCommand command,
  Entry? selectedEntry,
) {
  if (selectedEntry == null) {
    return TerminalResponse(
      success: false,
      logs: ['[FAIL] NO_ENTRY_MOUNTED'],
      nextSection: MenuSection.chronology,
    );
  }

  final detailCommand = findEntryDetailCommand(command.command);

  if (detailCommand == null) {
    return TerminalResponse(
      success: false,
      logs: ['[FAIL] UNKNOW_COMMAND_CONTEXT'],
    );
  }

  switch (detailCommand.type) {
    case EntryDetailCommandType.annotate:
      return _buildAnnotateResponse(ref, selectedEntry, command);

    case EntryDetailCommandType.delete:
      return _buildDeleteResponse(ref, selectedEntry, command);

    case EntryDetailCommandType.decode:
      return _buildDecodeResponse(ref, selectedEntry, command);

    case EntryDetailCommandType.back:
      return buildChronologyResponse(
        ref,
        mountLogs: [
          '[SYNC] ENTRY_NODE_EJECTED',
          '[RETU] CHRONOLOGY_INDEX_RESTORED',
        ],
      );
  }
}

TerminalResponse _buildAnnotateResponse(
  WidgetRef ref,
  Entry selectedEntry,
  ParsedCommand command,
) {
  final annotation = parseAnnotationBuffer(command.args);

  if (annotation == null) {
    return buildEntryDetailResponse(
      selectedEntry,
      mountLogs: ['[FAIL] ATTACH_SEQUENCE_EMPTY'],
    );
  }

  final updatedEntry = ref
      .read(entryProvider.notifier)
      .addAnnotation(selectedEntry.id, annotation);

  if (updatedEntry == null) {
    return buildEntryDetailResponse(
      selectedEntry,
      mountLogs: ['[FAIL] ATTACH_SEQUENCE_ABORTED'],
    );
  }

  return buildEntryDetailResponse(
    updatedEntry,
    mountLogs: ['[PTCH] ANNOTATION_ATTACHED'],
  );
}

TerminalResponse _buildDeleteResponse(
  WidgetRef ref,
  Entry selectedEntry,
  ParsedCommand command,
) {
  return TerminalResponse(
    success: true,
    logs: ['[PATCH] TODO'],
    clearOutput: false,
    clearTerminal: true,
  );
}

TerminalResponse _buildDecodeResponse(
  WidgetRef ref,
  Entry selectedEntry,
  ParsedCommand command,
) {
  final (recovery, updatedEntry) = ref
      .read(entryProvider.notifier)
      .fixEntry(selectedEntry);

  if (recovery.outcome == RecoveryOutcome.success) {
    return buildEntryDetailResponse(
      updatedEntry,
      mountLogs: ['[SUCC] RECOVERY_SUCCESS'],
    );
  }

  return buildEntryDetailResponse(
    updatedEntry,
    mountLogs: ['[FAIL] RECOVERY_FAILD'],
  );
}
