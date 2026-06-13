import 'package:signal/features/entry/models/corruption_profile.dart';

abstract class OutcomeExecution {
  const OutcomeExecution();
}

/// CreateEntryExecution
class CreateEntryExecution extends OutcomeExecution {
  final String title;
  final String content;

  const CreateEntryExecution({required this.title, required this.content});
}

/// Corrupt Entries Execution
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

class EntryCorruptionInstruction {
  final String entryId;
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

/// AppendAnnotationExecution
