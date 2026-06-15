import 'package:signal/features/anomaly_outcomes/models/corruption_profile.dart';
import 'package:signal/features/entry/models/annotation/annotation.dart';

class Entry {
  final String id;

  final String title;

  /// Inmubtable original backup
  final String rawContent;

  final DateTime createdAt;

  final List<Annotation> annotations;

  /// Corruption behavior profile
  final CorruptionProfile corruption;

  /// How recoverable this entry is
  /// 0 = lost forever
  /// 100 = fully recoverable
  final int recoverability;

  /// Number of times reconstructed/patched
  final int overwriteCount;

  const Entry({
    required this.id,
    required this.title,
    required this.rawContent,
    required this.createdAt,
    required this.annotations,
    this.corruption = const CorruptionProfile(),

    required this.recoverability,

    this.overwriteCount = 0,
  });

  Entry copyWith({
    String? title,
    List<Annotation>? annotations,
    int? corruptionLevel,
    CorruptionProfile? corruption,
    int? recoverability,
    int? overwriteCount,
  }) {
    return Entry(
      id: id,
      title: title ?? this.title,
      rawContent: rawContent,
      createdAt: createdAt,
      annotations: annotations ?? this.annotations,
      corruption: corruption ?? this.corruption,
      recoverability: recoverability ?? this.recoverability,
      overwriteCount: overwriteCount ?? this.overwriteCount,
    );
  }

  bool get hasAnnotations => annotations.isNotEmpty;

  int get annotationCount => annotations.length;

  bool get isCorrupted => corruption.totalLevel > 0;

  bool get isCritical => corruption.totalLevel >= 75;

  double get integrityRatio => 1 - (corruption.totalLevel / 100);

  bool get isRecoverable => recoverability > 0;
}



// 1. verificar recoverability > 0
// 2. verificar corruption > 0
// 3. calcular éxito según recoverability
// 4. restaurar algunos fragmentos
// 5. disminuir recoverability
// 6. incrementar recoveryAttempts
// 7. mostrar logs