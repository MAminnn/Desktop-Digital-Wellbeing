import 'package:desktop_digital_wellbeing/model/entities/application_stat.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../model/database_context/database_context.dart';
import '../model/entities/day.dart';

class DaysController {
  late Database _dbContext;

  DaysController() {
    _dbContext = DbContext().db;
  }

  Future<List<dynamic>> getDays() async {
    String query = "SELECT * FROM Days day "
        "INNER JOIN ApplicationStats applicationStat ON "
        "day.DateTime==applicationStat.DayDate";
    var daysQuery = await _dbContext.rawQuery(query);
    List<Day> days = [];
    for (int i = 0; i < daysQuery.length;) {
      var day = daysQuery[i];
      if (!days.any((d) => d.dayDate == daysQuery[i]['DateTime'])) {
        days.add(Day.fromQuery(daysQuery[i]));
      }
      while (daysQuery[i]['DateTime'] == day['DateTime']) {
        days
            .firstWhere((element) =>
                element.dayDate == DateTime.parse(day['DateTime'].toString()))
            .applicationStats
            .add(ApplicationStat.fromQueryIncludeDay(day));
        i++;
        if (i == daysQuery.length) {
          break;
        }
      }
    }
    return daysQuery.toList();
  }

  Future<List<Day>> getLastDays({required int count}) async {
    String query = "SELECT * FROM Days day "
        "INNER JOIN ApplicationStats applicationStat ON "
        "day.DateTime==applicationStat.DayDate";
    var daysQuery = await _dbContext.rawQuery(query);
    List<Day> days = [];
    for (int i = 0; i < daysQuery.length;) {
      var day = daysQuery[i];
      if (!days.any((d) => d.dayDate == daysQuery[i]['DateTime'])) {
        days.add(Day.fromQuery(daysQuery[i]));
      }
      while (daysQuery[i]['DateTime'] == day['DateTime']) {
        days
            .firstWhere((element) =>
                element.dayDate ==
                DateTime.parse(daysQuery[i]['DateTime'].toString()))
            .applicationStats
            .add(ApplicationStat.fromQueryIncludeDay(daysQuery[i]));
        i++;
        if (i == daysQuery.length) {
          break;
        }
      }
    }
    days.sort((d1, d2) => d2.dayDate.compareTo(d1.dayDate));
    return days.take(count).toList();
  }

  Future<Day> getDayOrDefault({required DateTime dayDate}) async {
    String query = "SELECT * FROM Days day "
        "INNER JOIN ApplicationStats applicationStat ON "
        "day.DateTime==applicationStat.DayDate WHERE day.DateTime='${DateFormat("yyyy-MM-dd 00:00:00").format(dayDate)}'";
    var dayQuery = await _dbContext.rawQuery(query);
    if (dayQuery.isEmpty) {
      return Day(
          dayDate:
              DateTime.parse(DateFormat("yyyy-MM-dd 00:00:00").format(dayDate)),
          applicationStats: []);
    }
    Day day = Day(
        dayDate: DateTime.parse(dayQuery[0]["DayDate"].toString()),
        applicationStats: []);
    for (int i = 0; i < dayQuery.length; i++) {
      day.applicationStats
          .add(ApplicationStat.fromQueryIncludeDay(dayQuery[i]));
    }
    return day;
  }
}
