enum MenuSection {
  idle,
  logEntry,
  chronology,
  archive,
  system,
}

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