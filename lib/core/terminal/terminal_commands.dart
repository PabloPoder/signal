bool isSelectCommand(String text) {
  return text.startsWith('/select ');
}

bool isSyncOrCommitCommand(String text) {
  return text == '/sync' || text == '/commit';
}

String extractSelectTarget(String text) {
  return text.replaceFirst('/select ', '').trim();
}