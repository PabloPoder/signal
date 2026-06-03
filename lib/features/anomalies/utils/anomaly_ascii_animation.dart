class AnomalyAsciiAnimation {
  final String name;
  final List<String> frames;
  // Una función opcional para personalizar el texto que rodea al dibujo
  final String Function(String currentFrame) templateBuilder;

  const AnomalyAsciiAnimation({
    required this.name,
    required this.frames,
    required this.templateBuilder,
  });
}

final List<AnomalyAsciiAnimation> anomaliesAsciiAnimationCatalog = [
  AnomalyAsciiAnimation(
    name: 'EYE_PARADIGM',
    frames: [
      '< O> ',
      '< O> ',
      '< O> ',
      '< o> ',
      '< -> ',
      '<  > ',
      '< -> ',
      '< o> ',
    ],
    templateBuilder: (frame) =>
        '''
  /\\    SOURCE: UNKNOWN    
 $frame  INDEX: UNKNOWN
  \\/    SECTOR: UNKNOWN
''',
  ),

  AnomalyAsciiAnimation(
    name: 'PULSE_SIGNAL',
    frames: [
      '(o.o)',
      '(-.-)',
      '( . )',
      '(   )',
      '( . )',
      '(-.-)',
      '(-.-)',
      '(o.o)',
    ],
    templateBuilder: (frame) =>
        '''
 ( )    SIG_TYPE: WAVE    
$frame   FREQ_MOD: ALTER
 ( )    BEACON: CRITICAL
''',
  ),

  AnomalyAsciiAnimation(
    name: 'PULSE_SIGNAL',
    frames: ['o', 'o', '.', ' ', '.', 'o', 'o'],
    templateBuilder: (frame) =>
        '''
  /\\    SIG_TYPE: WAVE    
 / $frame\\   FREQ_MOD: ALTER
/----\\  BEACON: CRITICAL
''',
  ),
  AnomalyAsciiAnimation(
    name: 'GLITCH_CORE',
    frames: ['▚▞', '▞▚', '██', '▒▒', '░░', '▞▚', '██', '░░'],
    templateBuilder: (frame) =>
        '''
 [!]    BUFFER: OVERFLOW  
 $frame   CORRUPT: SECTORS
 [!]    INTEG: CRIT!
''',
  ),
];
