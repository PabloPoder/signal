import 'package:signal/features/chronology/models/chronology_command.dart';

final chronologyCommands = [
  ChronologyCommand(
    type: ChronologyCommandType.inspect,
    aliases: ['/inspect', '/access', '/view', '/scan'],
    successLogs: [
      '[ OK ] MEMORY_NODE_ATTACHED',
      '[READ] ARCHIVE_STREAM_DECODED',
      '[SYNC] ENTRY_BUFFER_MOUNTED',
    ],
    errorLogs: [
      '[FAIL] NODE_ACCESS_DENIED',
      '[FAIL] MEMORY_FRAGMENT_NOT_FOUND',
      '[CRIT] ARCHIVE_STREAM_CORRUPTED',
    ],
  ),
  ChronologyCommand(
    type: ChronologyCommandType.filter,
    aliases: ['/filter', '/isolate', '/sort', '/query', '/exclude'],
    successLogs: [
      '[ OK ] TEMPORAL_FILTER_ACTIVE',
      '[SORT] CHRONO_STREAM_SEGMENTED',
      '[SYNC] MATCHING_NODES_ISOLATED',
    ],
    errorLogs: [
      '[FAIL] INVALID_FILTER_CRITERIA',
      '[FAIL] NO_NODES_MATCH_SEGMENT',
      '[CRIT] BUFFER_STREAM_OVERFLOW',
    ],
  ),
  ChronologyCommand(
    type: ChronologyCommandType.find,
    aliases: ['/find', '/search', '/locate', '/seek', '/track'],
    successLogs: [
      '[ OK ] TARGET_TRAJECTORY_FOUND',
      '[SEEK] SPECIFIC_NODE_LOCATED',
      '[SYNC] COORD_MATCH_ESTABLISHED',
    ],
    errorLogs: [
      '[FAIL] TARGET_PATTERN_NOT_FOUND',
      '[FAIL] QUERY_TIMED_OUT_NO_RECORDS',
      '[CRIT] ARCHIVE_INDEX_UNREADABLE',
    ],
  ),
  ChronologyCommand(
    type: ChronologyCommandType.select,
    aliases: ['/select', '/target', '/mark', '/hook', '/fetch'],
    successLogs: [
      '[ OK ] DATA_NODE_SELECTED',
      '[HOOK] TARGET_LOCKED_IN_BUFFER',
      '[SYNC] PIPELINE_STREAM_READY',
    ],
    errorLogs: [
      '[FAIL] SELECTION_INDEX_OUT_OF_BOUNDS',
      '[FAIL] CANNOT_LOCK_UNINDEXED_NODE',
      '[CRIT] PIPELINE_ACQUISITION_FAILED',
    ],
  ),
];