import 'application_stat.dart';

class Day {
  DateTime dayDate;
  List<ApplicationStat> applicationStats;

  Day({required this.dayDate, required this.applicationStats});

  factory Day.fromQuery(Map<String, Object?> json) {
    return Day(
        applicationStats: [],
        dayDate: DateTime.parse(json['DayDate'].toString()));
  }
}
