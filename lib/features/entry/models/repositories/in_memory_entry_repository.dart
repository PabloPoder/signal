import 'package:signal/features/entry/models/entry.dart';
import 'package:signal/features/entry/models/repositories/entry_repository.dart';

class InMemoryEntryRepository implements EntryRepository {
  final List<Entry> _entries = [
    Entry(
      id: '01',
      title: 'SIGNAL_BURST // UNKNOWN_ORIGIN',
      content: '''
[02:14:05] OVERRIDE DETECTED.
Array grid 04-B captured a 14.2Hz frequency spike. 
Audio translation loops a single rhythmic sequence: 
three rhythmic clicks followed by localized static. 
Background radiation is dropping below cosmic averages.
It almost sounds like... rhythmic breathing.
Data packaging failed. Source vector: UNDEFINED.''',
      createdAt: DateTime(2026, 05, 12, 02, 14),
      corruptionLevel: 12,
      overwriteCnt: 0,
    ),
    Entry(
      id: '02',
      title: 'MAINTENANCE_LOG // SECTOR_7',
      content: '''
[11:45:12] OPERATOR NOTE: Miller, J.
The repeating resonance in the coolant pipes hasn't stopped. 
Diagnostics show zero physical friction or mechanical failure.
The terminal frame is vibrating at a micro-level.
When the CRT screen refreshes, I can see phantom lines code 
interlocking between our standard telemetry.
I swear I didn't write those lines. Someone check the link.''',
      createdAt: DateTime(2026, 05, 18, 11, 45),
      corruptionLevel: 0,
      overwriteCnt: 0,
    ),
    Entry(
      id: '03',
      title: 'SYS_ALERT // MATRIX_DEGRADATION',
      content: '''
[23:59:59] CRITICAL: SPECTRAL SHIFT DETECTED.
Buffer dump reveals high-density structural corruption. 
Archived files from 2024 are rewriting themselves.
The word "WATCHING" has replaced 4096 blocks of empty memory.
If the terminal requests manual authorization for protocol 
"GHOST_BRIDGE", DO NOT ENGAGE.
The terminal is no longer waiting for our inputs.''',
      createdAt: DateTime(2026, 05, 25, 23, 59),
      corruptionLevel: 78,
      overwriteCnt: 0,
    ),
    Entry(
      id: '04', 
      title: 'SAVEGE_OPRESS', 
      content: '''
▒▒▒▒▒▒▒▒▒▒▒▒ DATA LOST▒▒▒▒▒▒▒▒▒▒▒
''', 
      createdAt: DateTime(2026, 05, 25, 23, 59),
      corruptionLevel: 100,
      overwriteCnt: 0,
    ),
  ];
  @override
  List<Entry> getAll() => _entries;

  @override
  void add(Entry entry) => _entries.add(entry);

  @override
  void remove(String id) =>
      _entries.removeWhere((e) => e.id == id);
}