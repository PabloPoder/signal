

import 'package:signal/features/entry/models/annotation/annotation.dart';

abstract class AnnotationRepository {
  List<Annotation> getByEntry(
    String entryId,
  );

  void add(Annotation annotation);

  void delete(String annotationId);
}