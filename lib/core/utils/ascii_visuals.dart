String buildPercentageBar(double integrityRatio) {
  const int totalBlocks = 9;

  final double preciseFilledBlocks =
      integrityRatio * totalBlocks;

  final int filledBlocks =
      preciseFilledBlocks.floor();

  String bar = '';

  for (int i = 0; i < totalBlocks; i++) {
    if (i < filledBlocks) {
      bar += '█';
    } else {
      final remainder =
          preciseFilledBlocks - filledBlocks;

      if (i == filledBlocks && remainder >= 0.5) {
        bar += '▒';
      } else {
        bar += '░';
      }
    }
  }

  return bar;
}

String buildFragmentationPattern(double ratio) {
  const totalBlocks = 8;

  final corruption =
      (ratio * totalBlocks).round();

  final chars =
      List.generate(totalBlocks, (_) => '·');

  for (int i = 0; i < corruption; i++) {

    final seed = (i * 7 + corruption) % 6;

    if (seed == 0) {
      chars[i] = '╳';
    } else if (seed <= 2) {
      chars[i] = '▚';
    } else {
      chars[i] = '▒';
    }
  }

  return chars.join(' ');
}