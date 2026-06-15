import 'package:signal/features/anomaly_outcomes/models/corruption_profile.dart';
import 'package:signal/features/entry/models/entry.dart';
import 'package:signal/features/entry/models/repositories/entry_repository.dart';

class InMemoryEntryRepository implements EntryRepository {
  final List<Entry> _entries = [
    Entry(
      id: '01',
      title: 'SIGNAL_BURST - UNKNOWN_ORIGIN',
      rawContent: '''
    OVERRIDE DETECTED.
    Array grid 04-B captured a 14.2Hz frequency spike.
    Audio translation loops a single rhythmic sequence:
    three rhythmic clicks followed by localized static.
    Background radiation is dropping below cosmic averages.
    It almost sounds like... rhythmic breathing.
    Data packaging failed. Source vector: UNDEFINED.
    ''',
      createdAt: DateTime(2026, 05, 12, 02, 14),
      annotations: [],
      corruption: const CorruptionProfile(
        signalNoise: 16,
        memoryDecay: 10,
        semanticDrift: 4,
        echoIntensity: 22,
        structuralCollapse: 8,
      ),
      recoverability: 96,
      overwriteCount: 0,
    ),

    Entry(
      id: '02',
      title: 'MAINTENANCE_LOG - SECTOR_7',
      rawContent: '''
    OPERATOR NOTE: Miller, J.
    The repeating resonance in the coolant pipes hasn't stopped.
    Diagnostics show zero physical friction or mechanical failure.
    The terminal frame is vibrating at a micro-level.
    When the CRT screen refreshes, I can see phantom lines code
    interlocking between our standard telemetry.
    I swear I didn't write those lines. Someone check the link.
    ''',
      createdAt: DateTime(2026, 05, 18, 11, 45),
      annotations: [],
      corruption: const CorruptionProfile(
        signalNoise: 0,
        memoryDecay: 0,
        semanticDrift: 0,
        echoIntensity: 0,
        structuralCollapse: 0,
      ),
      recoverability: 100,
      overwriteCount: 0,
    ),

    Entry(
      id: '03',
      title: 'SYS_ALERT - MATRIX_DEGRADATION',
      rawContent: '''
    CRITICAL: SPECTRAL SHIFT DETECTED.
    Buffer dump reveals high-density structural corruption.
    Archived files from 2024 are rewriting themselves.

    The word "WATCHING" has replaced 4096 blocks of empty memory.

    If the terminal requests manual authorization for protocol
    "GHOST_BRIDGE", DO NOT ENGAGE.

    The terminal is no longer waiting for our inputs.
    ''',
      createdAt: DateTime(2026, 05, 25, 23, 59),
      annotations: [],
      corruption: const CorruptionProfile(
        signalNoise: 65,
        memoryDecay: 84,
        semanticDrift: 89,
        echoIntensity: 62,
        structuralCollapse: 78,
      ),
      recoverability: 42,
      overwriteCount: 2,
    ),

    Entry(
      id: '04',
      title: 'SALVAGE_OPPRESS',
      rawContent: '''
    EMERGENCY SALVAGE REPORT.
    Recovery crews entered collapsed relay vault D-12.
    Biometric signatures were detected inside the sealed chamber.
    No personnel were officially assigned to the sector.

    One active terminal remained online.

    The screen displayed:
    "YOU SHOULD NOT HAVE OPENED THIS ARCHIVE."

    Transmission terminated immediately after extraction.
    ''',
      createdAt: DateTime(2026, 05, 25, 23, 59),
      annotations: [],
      corruption: const CorruptionProfile(
        signalNoise: 100,
        memoryDecay: 100,
        semanticDrift: 100,
        echoIntensity: 100,
        structuralCollapse: 100,
      ),
      recoverability: 100,
      overwriteCount: 0,
    ),

    Entry(
      id: '05',
      title: 'AUDIO_TRANSLATION - ECHO_VOID',
      rawContent: '''
    DEEP_SPACE_ARRAY // INTERCEPT.
    Decompression of telemetry package E-05 successful.
    The audio sub-carrier contains an echo of a human voice.
    Voice identification matches: Commander Sarah Vance.
    Note: Vance went missing during the 2022 orbital grid collapse.
    The voice repeats a single phrase over and over:
    "The static isn't empty. It's crowded."
    Decryption keys are warping in real-time.
    ''',
      createdAt: DateTime(2026, 05, 27, 14, 32),
      annotations: [],
      corruption: const CorruptionProfile(
        signalNoise: 40,
        memoryDecay: 22,
        semanticDrift: 30,
        echoIntensity: 56,
        structuralCollapse: 24,
      ),
      recoverability: 74,
      overwriteCount: 1,
    ),

    Entry(
      id: '06',
      title: 'HARDWARE_DIAGNOSTIC - CORE_TEMP',
      rawContent: '''
    WARNING: THERMAL VENTING MALFUNCTION.
    Mainframe cooling core is operating at 104% capacity.
    Physical temperature is rising without electrical scaling.
    Sensors inside the logic gate array report localized moisture.
    It smells like ozone and stagnant water inside the mainframe rack.
    The bios loop has altered its own boot instructions.
    The terminal is processing a parallel sub-routine called:
    "THE_RECEIVER_IS_READY".
    ''',
      createdAt: DateTime(2026, 05, 28, 03, 11),
      annotations: [],
      corruption: const CorruptionProfile(
        signalNoise: 20,
        memoryDecay: 0,
        semanticDrift: 20,
        echoIntensity: 78,
        structuralCollapse: 80,
      ),
      recoverability: 51,
      overwriteCount: 3,
    ),
  ];

  @override
  List<Entry> getAll() => _entries;

  @override
  void add(Entry entry) => _entries.add(entry);

  @override
  void remove(String id) => _entries.removeWhere((e) => e.id == id);

  @override
  void update(Entry entry) {
    final index = _entries.indexWhere((e) => e.id == entry.id);

    if (index == -1) return;

    _entries[index] = entry;
  }
}
