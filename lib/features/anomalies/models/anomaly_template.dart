enum AnomalyType { system, external }

enum AnomalyMood { ghost, cosmic, temporal, hostile, decay, system }

class AnomalyTemplate {
  final String code;
  //TODO: check type, i don't use it
  final AnomalyType type;
  final AnomalyMood mood;

  final String title;
  final String description;

  final double createEntryChance;
  final double corruptEntriesChance;
  final double appendAnnotationChance;
  final double pushSystemMessageChance;
  final double retrieveArtifactChance;

  const AnomalyTemplate({
    required this.code,
    required this.type,
    required this.mood,
    required this.title,
    required this.description,
    required this.createEntryChance,
    required this.corruptEntriesChance,
    required this.appendAnnotationChance,
    required this.pushSystemMessageChance,
    required this.retrieveArtifactChance,
  });

  @override
  String toString() {
    return '''
code: $code
title: $title
type: $type
description: $description
effects_chances: {
  append_annotation: $appendAnnotationChance
  corrupt_entries: $corruptEntriesChance
  create_entry: $createEntryChance
  push_system_message: $pushSystemMessageChance
  retrieve_artifact: $retrieveArtifactChance
}''';
  }
}
