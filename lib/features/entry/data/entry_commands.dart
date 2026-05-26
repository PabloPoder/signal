import 'package:signal/features/entry/models/entry_command.dart';

final entryCommands = [
  EntryCommand(
    type: EntryCommandType.save,
    aliases: ['/sync', '/commit', '/save'],
    successLogs: [
      '[ OK ] MEMORY_FRAGMENT_ARCHIVED',
      '[ OK ] ENTRY_CHECKSUM_VALID',
      '[SYNC] CHRONOLOGY_NODE_UPDATED',
    ],
    errorLogs: [
      '[FAIL] WRITE_ABORTED: EMPTY_BUFFER_STREAM',
      '[FAIL] DATA_CORRUPTION_DETECTED: INVALID_INTEGRITY',
      '[CRIT] LOCAL_DISK_WRITE_FAILED: SECTOR_LOCKED',
    ],
  ),
  // Other commands..
];