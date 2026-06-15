import 'package:signal/features/entry_detail/models/entry_details_command.dart';

final entryDetailCommands = [
  EntryDetailCommand(
    type: EntryDetailCommandType.annotate,
    aliases: ['/annotate', '/comment', '/note'],
    description: "Appends telemetry annotation to node stream.",
    successLogs: [
      '[ OK ] MEMORY_ANNOTATION_APPLIED',
      '[CORR] NODE_STRUCTURE_STABILIZED',
      '[SYNC] CHRONOLOGY_INDEX_UPDATED',
    ],
    errorLogs: [
      '[FAIL] ANNOTATION_SEQUENCE_REJECTED',
      '[FAIL] NODE_WRITE_CONFLICT_DETECTED',
      '[CRIT] MEMORY_LAYER_DESYNCHRONIZED',
    ],
  ),

  EntryDetailCommand(
    type: EntryDetailCommandType.delete,
    aliases: ['/purge', '/burn', '/erase'],
    description: "Purges node from the registry.",
    successLogs: [
      '[ OK ] MEMORY_NODE_PURGED',
      '[VOID] ARCHIVE_REFERENCE_REMOVED',
      '[SYNC] INDEX_REF_RECONSTRUCTED',
    ],
    errorLogs: [
      '[FAIL] NODE_PURGE_ABORTED',
      '[FAIL] ARCHIVE_LOCK_SIGNATURE_DETECTED',
      '[CRIT] CORE_MEMORY_ERASE_DENIED',
    ],
  ),

  EntryDetailCommand(
    type: EntryDetailCommandType.decode,
    aliases: ['/decode', '/fix', '/decrypt'],
    description: "Decrypts stream.",
    successLogs: [
      '[ OK ] SIGNAL_PATTERN_RESTORED',
      '[DCD*] CORRUPTION_LAYER_REMOVED',
      '[SYNC] MEMORY_FRAGMENT_STABILIZED',
    ],
    errorLogs: [
      '[FAIL] DECRYPTION_SEQUENCE_INVALID',
      '[FAIL] SIGNAL_RECOVERY_UNSTABLE',
      '[CRIT] ANOMALY_CLUSTER_PERSISTING',
    ],
  ),

  EntryDetailCommand(
    type: EntryDetailCommandType.back,
    aliases: ['/back', '/exit', '/return'],
    description: "Returns to the master directory.",
    successLogs: [
      '[ OK ] DETAIL_STREAM_TERMINATED',
      '[SYNC] DIRECTORY_INDEX_RECALLED',
    ],
    errorLogs: ['[FAIL] INTERFACE_THREAD_LOCKED'],
  ),
];
