import 'application.dart';
import 'day.dart';

class ApplicationStat {
  Duration usedTime;
  Day day;
  Application application;

  ApplicationStat(
      {required this.usedTime, required this.day, required this.application});

  factory ApplicationStat.fromJson(Map<String, Object?> json) {
    return ApplicationStat(
        usedTime: _parseDuration(json['UsedTime'] as String),
        day:
            Day(dayDate: DateTime.parse(json['DayDate'] as String), applicationStats: []),
        application: Application(
            id: json['ApplicationId'] as String, path: json['Path'] as String));
  }

  static Duration _parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }
}
