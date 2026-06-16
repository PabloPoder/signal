import 'package:signal/features/menu/models/menu_option.dart';

final menuOptions = [
  MenuOption(
    section: MenuSection.logEntry,
    label: '[01] LOG_ENTRY',
    aliases: ['/log_entry', '/new', '/log'],
    logs: [
      '[INIT] INTERFACE_BRIDGE_LOCAL_TEXT_RECORDER_ACTIVE',
      '[INIT] BUFFER_STREAM_OPENED',
      '[ OK ] CORE_VOLATILE_MOUNTED',
      '[WARN] AUTOSAVE_REDUNDANCY_LOW',
    ],
  ),
  MenuOption(
    section: MenuSection.chronology,
    label: '[02] CHRONOLOGY',
    aliases: ['/chronology', '/timeline'],
    logs: [
      '[INIT] INITIALIZING_CHRONOLOGY_FETCH',
      '[ OK ] DATABASE_LINK_ESTABLISHED',
      '[SYNC] MAPPING_TEMPORAL_SECTORS',
      '[ OK ] INDEX_INTEGRITY_VERIFIED',
    ],
  ),
  MenuOption(
    section: MenuSection.archive,
    label: '[03] ARCHIVE',
    aliases: ['/archive'],
    logs: [
      '[INIT] DATABASE_QUERY_EXTRACTING_CLASSIFIED_ARCHIVES_NODE',
      '[ OK ] SECURE_DECRYPTOR_ONLINE',
      '[ OK ] ANOMALY_DATABASE_LINKED',
      '[WARN] INTERCEPTED_RX_SIGNAL_WEAK',
    ],
  ),
  MenuOption(
    section: MenuSection.system,
    label: '[04] SYSTEM',
    aliases: ['/system', '/settings'],
    logs: [
      '[INIT] CORE_DIAGNOSTIC_FETCHING_HARDWARE_METRICS',
      '[ OK ] PALETTE_DRIVER_LOADED',
      '[ OK ] AUDIO_SYNTH_CALIBRATED',
      '[SYNC] HARDWARE_CONFIG_IDLE',
    ],
  ),
];
