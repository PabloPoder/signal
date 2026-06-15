class CorruptionProfile {
  final int echoIntensity;
  final int memoryDecay;
  final int semanticDrift;
  final int signalNoise;
  final int structuralCollapse;

  const CorruptionProfile({
    this.echoIntensity = 0,
    this.memoryDecay = 0,
    this.semanticDrift = 0,
    this.signalNoise = 0,
    this.structuralCollapse = 0,
  });

  CorruptionProfile copyWith({
    int? echoIntensity,
    int? memoryDecay,
    int? semanticDrift,
    int? signalNoise,
    int? structuralCollapse,
  }) {
    return CorruptionProfile(
      echoIntensity: echoIntensity ?? this.echoIntensity,
      memoryDecay: memoryDecay ?? this.memoryDecay,
      semanticDrift: semanticDrift ?? this.semanticDrift,
      signalNoise: signalNoise ?? this.signalNoise,
      structuralCollapse: structuralCollapse ?? this.structuralCollapse,
    );
  }

  /// Merge the actual CorruptionProfile whit the given one
  CorruptionProfile merge(CorruptionProfile other) {
    return CorruptionProfile(
      echoIntensity: accumulate(echoIntensity, other.echoIntensity),
      memoryDecay: accumulate(memoryDecay, other.memoryDecay),
      semanticDrift: accumulate(semanticDrift, other.semanticDrift),
      signalNoise: accumulate(signalNoise, other.signalNoise),
      structuralCollapse: accumulate(
        structuralCollapse,
        other.structuralCollapse,
      ),
    );
  }

  /// Applies an asymptotic increase capped at 100 through decreasing returns.
  int accumulate(int current, int incoming) {
    return (current + ((100 - current) * incoming / 100)).round();
  }

  /// Calculates and returns the weighted level
  /// of corruption of the Current CorruptionProfile.
  int get totalLevel {
    final score =
        echoIntensity * 0.15 +
        memoryDecay * 0.25 +
        semanticDrift * 0.20 +
        signalNoise * 0.15 +
        structuralCollapse * 0.25;

    return score.round();
  }

  @override
  String toString() {
    return '''{
echo_intensity: $echoIntensity
memory_decay: $memoryDecay
semantic_drift: $semanticDrift
signal_noise: $signalNoise
structural_collapse: $structuralCollapse
}''';
  }

  Map<String, dynamic> toJson() {
    return {
      'echoIntensity': echoIntensity,
      'memoryDecay': memoryDecay,
      'semanticDrift': semanticDrift,
      'signalNoise': signalNoise,
      'structuralCollapse': structuralCollapse,
    };
  }

  factory CorruptionProfile.fromJson(Map<String, dynamic> json) {
    return CorruptionProfile(
      echoIntensity: json['echoIntensity'],
      memoryDecay: json['memoryDecay'],
      semanticDrift: json['semanticDrift'],
      signalNoise: json['signalNoise'],
      structuralCollapse: json['structuralCollapse'],
    );
  }
}
