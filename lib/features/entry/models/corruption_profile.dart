class CorruptionProfile {
  final int signalNoise;    
  final int memoryDecay;    
  final int semanticDrift;
  final int echoIntensity;
  final int structuralCollapse;

  const CorruptionProfile({
    this.signalNoise = 0,
    this.memoryDecay = 0,
    this.semanticDrift = 0,
    this.echoIntensity = 0,
    this.structuralCollapse = 0,
  });
  
  CorruptionProfile copyWith({
    int? signalNoise,
    int? memoryDecay,
    int? semanticDrift,
    int? echoIntensity,
    int? structuralCollapse,
  }) {
    return CorruptionProfile(
      signalNoise: signalNoise ?? this.signalNoise,
      memoryDecay: memoryDecay ?? this.memoryDecay,
      semanticDrift: semanticDrift ?? this.semanticDrift,
      echoIntensity: echoIntensity ?? this.echoIntensity,
      structuralCollapse: structuralCollapse ?? this.structuralCollapse,
    );
  }
}

