/// Types of Menu Sections -> each panel
enum MenuSection {
  idle,
  logEntry,
  chronology,
  entryDetail,
  archive,
  system,
}

/// Representation of how a Menu Option is composed.
class MenuOption {
  final MenuSection section;
  final String label;
  final List<String> aliases;
  final List<String> logs;

  const MenuOption({
    required this.section,
    required this.label,
    required this.aliases,
    required this.logs,
  });
}