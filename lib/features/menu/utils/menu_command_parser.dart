

import 'package:signal/features/menu/models/menu_option.dart';
import 'package:signal/features/menu/data/menu_options.dart';


/// Searches for a registered [MenuOption] that matches the given input.
MenuOption? findMenuOptionFromCommand(String command) {
  final normalized = command
      .trim()
      .toLowerCase();
      // .replaceFirst('/', '');

  for (final option in menuOptions) {
    final matchesAlias = option.aliases.contains(normalized);

    if(matchesAlias) return option;
  }

  return null;
}