import 'package:signal/features/entry/models/entry.dart';
import 'package:signal/features/entry/models/repositories/entry_repository.dart';

class InMemoryEntryRepository implements EntryRepository {
  final List<Entry> _entries = [];

  @override
  List<Entry> getAll() => _entries;

  @override
  void add(Entry entry) => _entries.add(entry);

  @override
  void remove(String id) =>
      _entries.removeWhere((e) => e.id == id);
}