import 'package:signal/features/entry/models/entry.dart';

abstract class EntryRepository {
  List<Entry> getAll();
  void add(Entry entry);
  void remove(String id);
  void update(Entry entry);
}
