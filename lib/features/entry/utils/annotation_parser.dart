
/// Takes the [args] and join them into an [Annotation].
String? parseAnnotationBuffer(List<String> args) {
  final annotation = args.join(' ').trim();

  if (annotation.isEmpty) {
    return null;
  }

  return annotation;
}