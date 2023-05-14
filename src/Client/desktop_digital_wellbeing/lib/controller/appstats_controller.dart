import 'package:desktop_digital_wellbeing/model/database_context/database_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../model/entities/application_stat.dart';

class AppsStatsController {
  late Database _dbContext;

  AppsStatsController() {
    _dbContext = DbContext().db;
  }

  Future<List<ApplicationStat>> getApplicationsStatsOfDay(
      {required DateTime day}) async {
    var dayDate = DateTime(day.year, day.month, day.day);
    String query = "SELECT * FROM ApplicationStats applicationStat "
        "INNER JOIN Applications app ON "
        "applicationStat.ApplicationId=app.ID "
        "WHERE DayDate = '${DateFormat("yyyy-MM-dd HH:mm:ss").format(dayDate)}'";
    var applicationsStatsQuery = await _dbContext.rawQuery(query);
    return applicationsStatsQuery
        .map((e) => ApplicationStat.fromQuery(e))
        .toList();
  }
}
