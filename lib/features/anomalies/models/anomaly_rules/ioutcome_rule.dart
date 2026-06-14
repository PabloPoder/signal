import 'package:signal/features/anomaly_outcomes/models/corruption_profile.dart';
import 'package:signal/features/anomaly_outcomes/models/entry_seed.dart';

/// Represents a deferred consequence produced by an anomaly.
///
/// Outcome executions are pure descriptions of changes that should occur
/// in the system. They do not directly mutate state.
///
/// The responsibility of interpreting and applying these instructions
/// belongs to higher-level components, such as [EntryNotifier].
abstract class OutcomeExecution {
  const OutcomeExecution();
}

/// Instructs the system to create a new [Entry].
///
/// The entry is generated from an [EntrySeed], which contains the
/// initial title and raw content. Optionally, the entry may already
/// contain a [CorruptionProfile], allowing anomalies to create entries
/// that appear partially damaged from the moment they emerge.
class CreateEntryExecution extends OutcomeExecution {
  final EntrySeed entrySeed;
  final CorruptionProfile? profile;

  const CreateEntryExecution({required this.entrySeed, this.profile});
}

/// Instructs the system to apply corruption to one or more existing entries.
///
/// Each corruption operation is represented by an
/// [EntryCorruptionInstruction], describing which entry should be affected
/// and the corruption profile that must be merged into it.
class CorruptEntriesExecution extends OutcomeExecution {
  final List<EntryCorruptionInstruction> corruptions;

  const CorruptEntriesExecution({required this.corruptions});

  @override
  String toString() {
    return '''
---- [CORRUPTIONS] ----
corruptions: $corruptions
''';
  }
}

/// Describes a corruption operation targeting a specific entry.
///
/// This object does not perform the corruption itself. Instead, it acts as
/// an immutable instruction that higher-level systems can later interpret
/// and apply.
class EntryCorruptionInstruction {
  /// Identifier of the entry that should be corrupted.
  final String entryId;

  /// Corruption profile to merge into the target entry.
  final CorruptionProfile profile;

  const EntryCorruptionInstruction({
    required this.entryId,
    required this.profile,
  });

  @override
  String toString() {
    return '''{
entry_affected: $entryId
corruption_profile: $profile
}''';
  }
}

/// Instructs the system to create a note in an Entry
///
/// The note is represented by a String.
class AppendAnnotationExecution extends OutcomeExecution {
  final String entryId;
  final String annotation;

  const AppendAnnotationExecution({
    required this.entryId,
    required this.annotation,
  });
}

/// TODO: Future execution types:
///
/// - PushSystemMessageExecution
/// - RetrieveArtifactExecution
