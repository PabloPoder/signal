import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:signal/features/entry/models/entry.dart';

class InMemoryEntryRepository {
  static const _storageKey = 'entries';

  final List<Entry> _entries = [];

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    final raw = prefs.getString(_storageKey);

    if (raw == null) return;

    final decoded = jsonDecode(raw) as List;

    _entries
      ..clear()
      ..addAll(decoded.map((e) => Entry.fromJson(e)));
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();

    final json = jsonEncode(_entries.map((e) => e.toJson()).toList());

    await prefs.setString(_storageKey, json);
  }

  List<Entry> getAll() => List.unmodifiable(_entries);

  void add(Entry entry) {
    _entries.add(entry);
    unawaited(_persist());
  }

  void update(Entry entry) {
    final index = _entries.indexWhere((e) => e.id == entry.id);

    if (index == -1) return;

    _entries[index] = entry;

    unawaited(_persist());
  }

  void remove(String id) => _entries.removeWhere((e) => e.id == id);
}
