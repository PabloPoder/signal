/// Takes the [args] and join them into an [Annotation].
String? parseAnnotationBuffer(List<String> args) {
  final annotation = args.join(' ').trim();

  if (annotation.isEmpty) {
    return null;
  }

  return annotation;
}

/// Capitalize the first letter
String normalizeAnnotation(String text) {
  final trimmed = text.trim();

  if (trimmed.isEmpty) return trimmed;

  return trimmed[0].toUpperCase() + trimmed.substring(1);
}
