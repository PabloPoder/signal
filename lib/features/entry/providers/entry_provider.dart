import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/features/entry/models/entry.dart';
import 'package:signal/features/entry/models/corruption_profile.dart'; 
import 'package:signal/features/entry/models/annotation/annotation.dart';
import 'package:signal/features/entry/models/repositories/entry_repository.dart';
import 'package:signal/features/entry/models/repositories/in_memory_entry_repository.dart';

final entryRepositoryProvider = Provider<EntryRepository>((ref) {
  return InMemoryEntryRepository();
});

final entryProvider = NotifierProvider<EntryNotifier, List<Entry>>(
  EntryNotifier.new,
);

class EntryNotifier extends Notifier<List<Entry>> {
  late final EntryRepository _repository;

  @override
  List<Entry> build() {
    _repository = ref.read(entryRepositoryProvider);
    return _repository.getAll();
  }

  /// Creates a new system [Entry] incorporating the full [CorruptionProfile].
  Entry createEntry({
    required String title,
    required String content,
    List<Annotation> annotations = const [],
    int corruptionLevel = 0,
    int signalNoise = 0,
    int memoryDecay = 0,
    int semanticDrift = 0,
    int echoIntensity = 0,
    int structuralCollapse = 0,
    int recoverability = 100,
  }) {
    final entry = Entry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      rawContent: content,
      annotations: annotations,
      createdAt: DateTime.now(),
      corruptionLevel: corruptionLevel,
      corruption: CorruptionProfile(
        signalNoise: signalNoise,
        memoryDecay: memoryDecay,
        semanticDrift: semanticDrift,
        echoIntensity: echoIntensity,
        structuralCollapse: structuralCollapse,
      ),
      recoverability: recoverability,
      overwriteCount: 0,
    );

    _repository.add(entry);

    state = [..._repository.getAll()];

    return entry;
  }

  void deleteEntry(String id) {
    _repository.remove(id);
    state = [..._repository.getAll()];
  }

  void updateEntry(Entry updatedEntry) {
    final entries = _repository.getAll();
    final index = entries.indexWhere((e) => e.id == updatedEntry.id);

    if (index == -1) return;

    entries[index] = updatedEntry;

    state = [...entries];
  }

  void applyCorruption(
    String entryId,
    CorruptionProfile corruption,
  ) {
    final entry = findEntry(entryId);

    if (entry == null) return;

    updateEntry(
      entry.copyWith(
        corruption: corruption,
      ),
    );
  }

  Entry? findEntry(String id) {
    for (final entry in state) {
      if (entry.id == id) return entry;
    }

    return null;
  }

  void incrementOverwriteCount(String entryId) {
    final entry = findEntry(entryId);

    if (entry == null) return;

    updateEntry(
      entry.copyWith(
        overwriteCount: entry.overwriteCount + 1,
      ),
    );
  }

  Entry? addAnnotation(
    String entryId,
    String note,
  ) {
    final entry = findEntry(entryId);

    if (entry == null) return null;

    final annotation = Annotation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      content: note,
    );

    final updatedEntry = entry.copyWith(
      annotations: [
        ...entry.annotations,
        annotation,
      ]
    );

    updateEntry(updatedEntry);

    return updatedEntry;
  }
}