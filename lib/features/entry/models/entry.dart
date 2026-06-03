import 'package:signal/features/entry/models/corruption_profile.dart';
import 'package:signal/features/entry/models/annotation/annotation.dart';

class Entry {
  final String id;

  /// Original human-readable title
  final String title;

  /// Inmubtable original backup
  final String rawContent;

  final DateTime createdAt;

  final List<Annotation> annotations;

  /// Global corruption severity
  final int corruptionLevel;

  /// Corruption behavior profile
  final CorruptionProfile corruption;
  
  /// How recoverable this entry is
  /// 0 = lost forever
  /// 100 = fully recoverable
  final int recoverability;

  /// Number of times reconstructed/patched
  final int overwriteCount;

  
  /// TODO: add this, fase 2
  // /// System-generated anomaly markers
  // final List<String> anomalyFlags;

  // /// Prevents modifications/deletion
  // final bool locked;
  
  // /// Simulated integrity checksum
  // final String checksum;

  const Entry({
    required this.id,
    required this.title,
    required this.rawContent,
    required this.createdAt,
    required this.annotations,
    required this.corruptionLevel,
    this.corruption = const CorruptionProfile(),
    required this.recoverability,
    this.overwriteCount = 0,
    // this.anomalyFlags = const [],
    // this.locked = false,
    // required this.checksum,
  });
  
  Entry copyWith({
    String? title,
    List<Annotation>? annotations,
    int? corruptionLevel,
    CorruptionProfile? corruption,
    int? recoverability,
    int? overwriteCount,
    // List<String>? anomalyFlags,
    // bool? locked,
    // String? checksum,
  }) {
    return Entry(
      id: id,
      title: title ?? this.title,
      rawContent: rawContent,
      createdAt: createdAt,
      annotations: annotations ?? this.annotations,
      corruptionLevel:
          corruptionLevel ?? this.corruptionLevel,
      corruption: corruption ?? this.corruption,
      recoverability:
          recoverability ?? this.recoverability,
      overwriteCount:
          overwriteCount ?? this.overwriteCount,
      // anomalyFlags:
      //     anomalyFlags ?? this.anomalyFlags,
      // locked:
      //     locked ?? this.locked,
      // checksum:
      //     checksum ?? this.checksum,
    );
  }
  bool get hasAnnotations =>
    annotations.isNotEmpty;

  int get annotationCount =>
      annotations.length;

  bool get isCorrupted =>
    corruptionLevel > 0;

  bool get isCritical =>
    corruptionLevel >= 75;

  double get integrityRatio =>
    1 - (corruptionLevel / 100);

  bool get isRecoverable =>
    recoverability > 0;
}