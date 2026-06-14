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
}
