import 'package:signal/features/anomalies/models/anomaly_template.dart';

final Map<AnomalyMood, List<String>> annotationsCatalog = {
  AnomalyMood.ghost: [
    'Someone else wrote this.',
    'I remember this entry differently.',
    'You left before finishing this note.',
  ],

  AnomalyMood.temporal: [
    'This annotation was added tomorrow.',
    'You will read this twice.',
    'The previous version was more complete.',
  ],

  AnomalyMood.cosmic: [
    'Coordinates do not match known space.',
    'Signal source remains unidentified.',
    'A second pulse was detected.',
  ],

  AnomalyMood.system: [
    'Checksum mismatch.',
    'User context lost.',
    'Background process attached to entry.',
  ],

  AnomalyMood.decay: [
    'Part of this annotation is missing...',
    'Memory sectors unavailable.',
    'Recovered fragment incomplete.',
  ],

  AnomalyMood.hostile: [
    'STOP READING.',
    'THIS ENTRY IS NOT YOURS.',
    'ACCESS DENIED.',
  ],
};
