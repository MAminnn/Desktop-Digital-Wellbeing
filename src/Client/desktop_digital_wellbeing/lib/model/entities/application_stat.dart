import 'application.dart';
import 'day.dart';

class ApplicationStat {
  Duration usedTime;
  Day? day;
  Application? application;

  ApplicationStat({required this.usedTime, this.day, this.application});

  factory ApplicationStat.fromQueryIncludeDay(Map<String, Object?> query) {
    return ApplicationStat(
      usedTime: _parseDuration(query['UsedTime'] as String),
      day: Day.fromQuery(query),
    );
  }

  factory ApplicationStat.fromQueryIncludeApp(Map<String, Object?> query) {
    return ApplicationStat(
        usedTime: _parseDuration(query['UsedTime'] as String),
        application: Application.fromQuery(query));
  }

  factory ApplicationStat.fromQuery(Map<String, Object?> query) {
    return ApplicationStat(
        usedTime: _parseDuration(query['UsedTime'] as String),
        day: Day.fromQuery(query),
        application: Application.fromQuery(query));
  }

  static Duration _parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int seconds;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    seconds = (double.parse(parts[parts.length - 1])).round();
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }
}
