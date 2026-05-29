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
}

