part of 'http.dart';

void _printLogs(
  Json logs,
  StackTrace? stackTrace,
) {
  if (kDebugMode) {
    log(
      '''
--------------------------------------
${const JsonEncoder.withIndent('  ').convert(logs)},
--------------------------------------
''',
      stackTrace: stackTrace,
    );
  }
}
