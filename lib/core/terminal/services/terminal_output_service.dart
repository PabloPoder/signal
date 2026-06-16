///
class TerminalOutputService {
  static Future<void> appendLogs({
    required List<String> lines,
    required Duration delay,
    required void Function(String line) onLine,
  }) async {
    for (final line in lines) {
      await Future.delayed(delay);
      onLine(line);
    }
  }
}
