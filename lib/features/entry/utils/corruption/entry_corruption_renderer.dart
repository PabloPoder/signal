import 'package:signal/features/entry/models/entry.dart';

String renderCorruptedText(Entry entry) {
  String text = entry.rawContent;

  text = _applySignalNoise(
    text,
    entry.corruption.signalNoise,
  );

  text = _applyWordMutation(
    text,
    entry.corruption.semanticDrift,
  );

  text = _applyRecursiveEcho(
    text,
    entry.corruption.echoIntensity,
  );

  text = _applyCharacterCorruption(
    text,
    entry.corruption.memoryDecay,
  );

  text = applyStructuralCollapse(
    text,
    entry.corruption.structuralCollapse,
  );

  return text;
}

String _applySignalNoise(
  String text,
  int noise,
) {
  if (noise <= 0) return text;

  final chars = text.split('');

  final ratio =
      (noise / 100).clamp(0.0, 1.0);

  // mucho más suave que corrupción
  final noiseChance =
      ratio * 0.12;

  const noiseSymbols = [
    '|',
    '!',
    ':',
    '.',
    '°',
    '~',
  ];

  for (int i = 0; i < chars.length; i++) {

    final char = chars[i];

    // preservar estructura
    if (char.trim().isEmpty) continue;

    // no tocar símbolos estructurales
    if (RegExp(r'[^\w]').hasMatch(char)) {
      continue;
    }

    final seed =
        ((i * 11) + (noise * 7)) % 100;

    if (seed > noiseChance * 100) {
      continue;
    }

    final symbolIndex =
        ((i * 13) + noise) %
        noiseSymbols.length;

    if (seed % 2 == 0) {

      chars[i] =
          noiseSymbols[symbolIndex];
    }
    else {
      chars[i] =
          char == char.toUpperCase()
          ? char.toLowerCase()
          : char.toUpperCase();
    }
  }

  return chars.join();
}

String _applyRecursiveEcho(
  String text,
  int level,
) {
  if (level < 45) return text;

  final lines = text.split('\n');

  final output = <String>[];

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];

    output.add(line);

    // skip empty lines
    if (line.trim().isEmpty) continue;

    final seed =
        ((i * 23) + (level * 11)) % 100;

    final echoChance =
        (level - 40) * 0.8;

    if (seed > echoChance) continue;

    // number of echoes
    final echoCount =
        1 + (seed % 3);

    for (int j = 0; j < echoCount; j++) {

      final degraded =
          _degradeEcho(
            line,
            j,
          );

      output.add(degraded);
    }
  }

  return output.join('\n');
}

String _degradeEcho(
  String line,
  int depth,
) {
  if (depth == 0) {
    return line;
  }

  final words = line.split(' ');

  if (words.length <= 2) {
    return line;
  }

  // progressively cut the line
  final remaining =
      words.take(words.length - depth);

  if (depth == 1) {
    return remaining.join(' ');
  }

  return remaining
      .take(remaining.length ~/ 2)
      .join(' ');
}

String applyStructuralCollapse(
  String text,
  int level,
) {
  if (level < 70) return text;

  final lines = text.split('\n');

 const collapseMessages = [
    '''▒▒▒▒▒▒▒▒▒
▒▒ DATA LOST ▒▒
▒▒▒▒▒▒▒▒▒''',

    '''▒▒▒▒▒▒▒▒▒
▒▒ SECT_ERR ▒▒
▒▒▒▒▒▒▒▒▒''',

    '''▒▒▒▒▒▒▒▒▒
▒▒ ACC_VIOL ▒▒
▒▒▒▒▒▒▒▒▒''',

    '▒▒▒ [ DESYNC ] ▒▒▒',

    '▒▒ BUF_FAIL ▒▒',

    '▒▒▒ [ NULL ] ▒▒▒',
    
    '▒▒▒▒▒▒▒▒▒',
  ];

  for (int i = 0; i < lines.length; i++) {

    if (lines[i].trim().isEmpty) continue;

    final seed =
        (i * 31 + level) % 100;

    if (seed < level * 0.4) {

      final symbolIndex = 
          ((i * 17) + (level * 31)) %
          collapseMessages.length;

      lines[i] = collapseMessages[symbolIndex];
    }
  }

  return lines.join('\n');
}

String _applyWordMutation(
  String text,
  int level,
) {
  
  if (level < 35) return text;

  final words = text.split(' ');

  for (int i = 0; i < words.length; i++) {

    final seed = (i * 19 + level) % 100;

    if (seed > level * 0.35) continue;

    final word = words[i];

    if (word.length < 5) continue;

    // invert word
    if (seed % 2 == 0) {
      words[i] =
          word.split('').reversed.join();
    }
    // duplicate word
    else {
      words[i] =
          '$word $word';
    }
  }
  
  return words.join(' ');
}

String _applyCharacterCorruption(
  String text,
  int level,
) {
  final ratio = level / 100;

  ///curve
  final corruptionChance = ratio * ratio * 0.22;

  final chars = text.split('');

  const corruptionSymbols = [
    '░',
    '▒',
    '█',
    '▞',
  ];

  for(int i = 0; i < chars.length; i ++) {
    final char = chars[i];

    // dont break estructure
    if (char.trim().isEmpty) continue;

    // dont break puntuation "."
    if (RegExp(r'[^\w]').hasMatch(char)) continue;

    final seed = (i * 13 + level) % 100;

    if (seed < corruptionChance * 100) {

      final symbolIndex = 
          ((i * 17) + (level * 31)) %
          corruptionSymbols.length;

      chars[i] = corruptionSymbols[symbolIndex];
    }
  }

  return chars.join();
}