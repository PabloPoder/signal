enum AnomalyType { system, external }

enum AnomalyStatus { active, resolved }

enum AnomalyTrigger {
  threeAm,
  everyTenEntries,
  randomChance,
  longSilence,
  abandonedArchive,
}

class Anomaly {
  final String id;

  final String code;

  final AnomalyType type;

  final String title;
  final String description;

  final DateTime detectedAt;

  final bool isPersistent;

  final AnomalyStatus status;

  final DateTime? lastOutcomeAt;

  /// For dev_log
  final AnomalyTrigger trigger;

  const Anomaly({
    required this.id,
    required this.code,
    required this.type,
    required this.title,
    required this.description,
    required this.detectedAt,
    required this.isPersistent,
    required this.status,
    required this.lastOutcomeAt,
    required this.trigger,
  });

  Anomaly copyWith({AnomalyStatus? status}) {
    return Anomaly(
      id: id,
      code: code,
      type: type,
      title: title,
      description: description,
      detectedAt: detectedAt,
      isPersistent: isPersistent,
      status: status ?? this.status,
      lastOutcomeAt: lastOutcomeAt,
      trigger: trigger,
    );
  }

  bool get isActive => status == AnomalyStatus.active;

  bool get isResolved => status == AnomalyStatus.resolved;
}
