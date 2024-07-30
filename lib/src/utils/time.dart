// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class Time {
  static final DateFormat _formYearDateTime = DateFormat('yyyy-MM-dd HH:mm:ss');

  static int now({mins = 0, secs = 0, days = 0}) => DateTime.now()
      .add(Duration(minutes: mins, seconds: secs, days: days))
      .millisecondsSinceEpoch;

  static String nowDateTime() => _formYearDateTime.format(DateTime.now());
}
