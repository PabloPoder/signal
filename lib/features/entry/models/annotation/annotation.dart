enum AnnotationSource { user, anomaly }

class Annotation {
  final String id;
  final String content;
  final DateTime createdAt;
  final AnnotationSource source;

  Annotation({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.source,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'source': source.name.toString(),
    };
  }

  factory Annotation.fromJson(Map<String, dynamic> json) {
    return Annotation(
      id: json['id'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      source: AnnotationSource.values.firstWhere(
        (e) => e.name == json['source'],
      ),
    );
  }
}
