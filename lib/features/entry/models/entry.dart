class Entry {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final int corruptionLevel;
  final int overwriteCnt;
  // final String[] tags
  // final anomalyFlags
  // locked
  // checksum

  const Entry({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.corruptionLevel,
    this.overwriteCnt = 0,
  });
  
  Entry copyWith({
    String? title,
    String? content,
    int? corruptionLevel,
    int? overwriteCnt,
  }) {
    return Entry(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt,
      corruptionLevel: corruptionLevel ?? this.corruptionLevel,
      overwriteCnt: overwriteCnt ?? this.overwriteCnt,
    );
  }

  @override
  String toString() => '$id, $title, $content, $createdAt, $corruptionLevel';
}