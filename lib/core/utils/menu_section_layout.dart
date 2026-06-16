import 'package:signal/features/menu/models/menu_option.dart';

extension MenuSectionLayout on MenuSection {
  (int output, int input) get consoleDistribution {
    return switch (this) {
      MenuSection.chronology => (5, 1), // CHORNOLOGY MODE
      MenuSection.entryDetail => (5, 1), // INSPECT MODE
      MenuSection.logEntry => (2, 5), // Writing Mode
      _ => (5, 1), // DEFAULT
    };
  }
}
