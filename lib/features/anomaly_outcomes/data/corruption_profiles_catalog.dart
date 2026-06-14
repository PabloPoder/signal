import 'package:signal/features/anomalies/models/anomaly_template.dart';
import 'package:signal/features/anomaly_outcomes/models/corruption_profile.dart';

const corruptionCatalog = <AnomalyMood, List<CorruptionProfile>>{
  AnomalyMood.ghost: [
    // Whisper
    CorruptionProfile(
      echoIntensity: 80,
      memoryDecay: 15,
      signalNoise: 10,
      semanticDrift: 30,
      structuralCollapse: 0,
    ),
    // Possession
    CorruptionProfile(
      echoIntensity: 40,
      memoryDecay: 30,
      signalNoise: 20,
      semanticDrift: 70,
      structuralCollapse: 10,
    ),
    // Haunting
    CorruptionProfile(
      echoIntensity: 70,
      memoryDecay: 60,
      signalNoise: 0,
      semanticDrift: 20,
      structuralCollapse: 0,
    ),
  ],
  AnomalyMood.temporal: [
    // Time Loop
    CorruptionProfile(
      echoIntensity: 90,
      memoryDecay: 0,
      signalNoise: 0,
      semanticDrift: 10,
      structuralCollapse: 40,
    ),
    // Chronological Collapse
    CorruptionProfile(
      echoIntensity: 30,
      memoryDecay: 20,
      signalNoise: 10,
      semanticDrift: 30,
      structuralCollapse: 80,
    ),
    //Future Bleed
    CorruptionProfile(
      echoIntensity: 20,
      memoryDecay: 0,
      signalNoise: 0,
      semanticDrift: 80,
      structuralCollapse: 20,
    ),
  ],
  AnomalyMood.cosmic: [
    // Deep Space Static
    CorruptionProfile(
      signalNoise: 80,
      memoryDecay: 20,
      semanticDrift: 20,
      echoIntensity: 0,
      structuralCollapse: 0,
    ),
    // Orbital Drift
    CorruptionProfile(
      signalNoise: 30,
      memoryDecay: 30,
      semanticDrift: 60,
      echoIntensity: 0,
      structuralCollapse: 20,
    ),
    // Stella Fragmentation
    CorruptionProfile(
      signalNoise: 50,
      memoryDecay: 50,
      semanticDrift: 40,
      echoIntensity: 10,
      structuralCollapse: 40,
    ),
  ],
  AnomalyMood.hostile: [
    // Cascade Failure
    CorruptionProfile(
      signalNoise: 90,
      memoryDecay: 70,
      semanticDrift: 40,
      echoIntensity: 0,
      structuralCollapse: 60,
    ),
    // Agresive Rewrite
    CorruptionProfile(
      signalNoise: 40,
      memoryDecay: 20,
      semanticDrift: 90,
      echoIntensity: 10,
      structuralCollapse: 40,
    ),
    // Data Assault
    CorruptionProfile(
      signalNoise: 100,
      memoryDecay: 50,
      semanticDrift: 20,
      echoIntensity: 0,
      structuralCollapse: 80,
    ),
  ],
  AnomalyMood.decay: [
    // Bit Rot
    CorruptionProfile(
      memoryDecay: 80,
      signalNoise: 20,
      semanticDrift: 10,
      echoIntensity: 0,
      structuralCollapse: 0,
    ),
    // Entropy
    CorruptionProfile(
      memoryDecay: 50,
      signalNoise: 30,
      semanticDrift: 30,
      echoIntensity: 10,
      structuralCollapse: 50,
    ),
    // Archive Erosion
    CorruptionProfile(
      memoryDecay: 90,
      signalNoise: 10,
      semanticDrift: 10,
      echoIntensity: 20,
      structuralCollapse: 10,
    ),
  ],
  AnomalyMood.system: [
    // Buffer Overflow
    CorruptionProfile(
      signalNoise: 80,
      memoryDecay: 30,
      semanticDrift: 20,
      echoIntensity: 0,
      structuralCollapse: 70,
    ),
    // Pointer Failure
    CorruptionProfile(
      signalNoise: 20,
      memoryDecay: 60,
      semanticDrift: 70,
      echoIntensity: 0,
      structuralCollapse: 30,
    ),
    // Kernel Panic
    CorruptionProfile(
      signalNoise: 90,
      memoryDecay: 80,
      semanticDrift: 40,
      echoIntensity: 0,
      structuralCollapse: 90,
    ),
  ],
};
