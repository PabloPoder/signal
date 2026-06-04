import 'package:signal/core/constants/colors.dart';
import 'package:signal/core/terminal/responses/terminal_response.dart';
import 'package:signal/core/utils/date_parser.dart';
import 'package:signal/features/entry/models/annotation/annotation.dart';
import 'package:signal/features/entry/models/entry.dart';
import 'package:signal/features/entry/utils/corruption/entry_corruption_renderer.dart';
import 'package:signal/features/menu/models/menu_option.dart';

TerminalResponse buildEntryDetailResponse(
  Entry entry, {
  List<String> mountLogs = const [],
}) {
  final wordCount = entry.rawContent.trim().split(RegExp(r'\s+')).length;

  final charCount = entry.rawContent.length;

  final renderedContent = renderCorruptedText(entry);

  final annotationsLogs = _buildAnnotationsLogs(entry.annotations);

  return TerminalResponse(
    success: true,
    logs: [
      ...mountLogs,
      '[${entry.id}] DATA_BUFFER_STREAM',
      '─' * maxTerminalWidth,
      'TITLE: ${entry.title}',
      'DATE: ${formatTime(entry.createdAt)}',
      'WORD_COUNT: $wordCount CHAR_COUNT: $charCount',
      'NODE_ID: ARG-01_CHRONO_N${entry.id}',
      // 'RAW_TELEMETRY: [ $rawTelemetry ]',
      'ANNOTATIONS_COUNT: ${entry.annotationCount.toString().padLeft(3, '0')}',
      '─' * maxTerminalWidth,
      renderedContent,
      ...annotationsLogs,
    ],
    nextSection: MenuSection.entryDetail,
    selectedEntry: entry,
    clearOutput: true,
    clearTerminal: true,
  );
}

List<String> _buildAnnotationsLogs(List<Annotation> annotations) {
  if (annotations.isEmpty) return [];

  final logs = <String>[''];

  for (int i = 0; i < annotations.length; i++) {
    final annotation = annotations[i];

    logs.add(
      '[P-${(i + 1).toString().padLeft(3, '0')} | '
      '${formatTime(annotation.createdAt)}]',
    );

    logs.add(annotation.content);
    logs.add('');
  }

  return logs;
}
