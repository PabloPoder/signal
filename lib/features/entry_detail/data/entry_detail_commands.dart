import 'package:signal/features/entry_detail/models/entry_details_command.dart';

final entryDetailCommands = [
  EntryDetailCommand(
    type: EntryDetailCommandType.patch,
    aliases: ['/patch', '/rewrite', '/inject', '/override', '/edit', '/mod'],
    successLogs: [
      '[ OK ] MEMORY_PATCH_APPLIED',
      '[CORR] NODE_STRUCTURE_STABILIZED',
      '[SYNC] CHRONOLOGY_INDEX_UPDATED',
    ],
    errorLogs: [
      '[FAIL] PATCH_SEQUENCE_REJECTED',
      '[FAIL] NODE_WRITE_CONFLICT_DETECTED',
      '[CRIT] MEMORY_LAYER_DESYNCHRONIZED',
    ],
  ),

  EntryDetailCommand(
    type: EntryDetailCommandType.delete,
    aliases: ['/delete', '/purge', '/burn', '/erase', '/wipe'],
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
    aliases: ['/decode', '/recover', '/restore', '/repair', '/fix', '/decrypt'],
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
    aliases: ['/back'],
    successLogs: [
    ],
    errorLogs: [
    ],
  ),
];