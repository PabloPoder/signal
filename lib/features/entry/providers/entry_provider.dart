import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signal/features/entry/models/entry.dart';
import 'package:signal/features/entry/models/repositories/entry_repository.dart';
import 'package:signal/features/entry/models/repositories/in_memory_entry_repository.dart';

final entryRepositoryProvider = Provider<EntryRepository>((ref) {
  return InMemoryEntryRepository();
});


final entryProvider =
    NotifierProvider<EntryNotifier, List<Entry>>(EntryNotifier.new);


class EntryNotifier extends Notifier<List<Entry>> {
  late final EntryRepository _repository;

  @override
  List<Entry> build() {
    _repository = ref.read(entryRepositoryProvider);
    return _repository.getAll();
  }

  Entry createEntry({
    required String title,
    required String content,
    required int corruptionLevel,
  }) {
    final entry = Entry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      createdAt: DateTime.now(), 
      corruptionLevel: corruptionLevel,
    );

    _repository.add(entry);
    state = _repository.getAll();
    return entry;
  }

  void deleteEntry(String id) {
    _repository.remove(id);
    state = _repository.getAll();
  }
}