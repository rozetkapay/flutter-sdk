// ignore_for_file: avoid_print

import 'time.dart';

class Log {
  static const int levelErr = 1;
  static const int levelWarn = 2;
  static const int levelInfo = 3;
  static const int levelDebug = 4;

  static const String nameErr = "ERR";
  static const String nameWarn = "WARN";
  static const String nameInfo = "INFO";
  static const String nameDebug = "DEBUG";

  static int level = levelInfo;

  static void _log(String msg, int level, String name, [StackTrace? err]) {
    if (_isAllowed(level)) {
      print(_line(name, msg));
      if (err != null) print(err);
    }
  }

  static void debug(String msg) => _log(msg, levelDebug, nameDebug);
  static void info(String msg) => _log(msg, levelInfo, nameInfo);
  static void warn(String msg) => _log(msg, levelWarn, nameWarn);
  static void err(String msg, [StackTrace? trace]) =>
      _log(msg, levelErr, nameErr, trace);

  static String _line(String name, String msg) =>
      "${Time.nowDateTime()} $name $msg";

  static bool _isAllowed(int level) => level <= Log.level;

  static bool isDebug() => _isAllowed(levelDebug);

  static void http(
    String method,
    Uri uri,
    Map<String, String>? hdrs,
    String? body,
  ) {
    final log = StringBuffer("-X $method '${uri.toString()}'");

    if (hdrs != null) {
      hdrs.forEach((k, v) => log.write(" -H '$k: $v'"));
    }
    if (body != null) log.write(" -d '$body'");

    print(log.toString());
  }
}
