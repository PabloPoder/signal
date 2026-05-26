

import 'package:signal/features/menu/models/menu_option.dart';
import 'package:signal/features/menu/data/menu_options.dart';

/// Find and return the MenuOption from the [command].
///
/// Return 'MenuOption' or null
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