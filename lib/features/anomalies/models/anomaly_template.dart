import 'package:signal/features/anomalies/models/anomaly.dart';

class AnomalyTemplate {
  final String code;

  final AnomalyType type;

  final String title;
  final String description;

  final bool isPersistent;

  final double affectEntriesChance;
  final double createEntriesChance;
  final double generateArtifactsChance;
  final double generateMessagesChance;

  const AnomalyTemplate({
    required this.code,
    required this.type,
    required this.title,
    required this.description,
    required this.isPersistent,
    required this.affectEntriesChance,
    required this.createEntriesChance,
    required this.generateArtifactsChance,
    required this.generateMessagesChance,
  });
}
