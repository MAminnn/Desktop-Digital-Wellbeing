import 'package:desktop_digital_wellbeing/model/database_context/database_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../model/entities/application_stat.dart';

class AppsStatsController {
  late Database _dbContext;

  AppsStatsController() {
    _dbContext = DbContext().db;
  }

  Future<List<ApplicationStat>> getApplicationsStats() async {
    var dayDate = DateTime(DateTime
        .now()
        .year, DateTime
        .now()
        .month, DateTime
        .now()
        .day, 0, 0, 0);
    // debugPrint(dayDate.toString().substring(0,19));
    debugPrint("SELECT * FROM ApplicationStats "
        "JOIN Applications ON "
        "ApplicationStats.ApplicationId==Applications.ID "
        "WHERE DayDate = '${dayDate.toString().substring(0,19)}'");
    var applicationsStatsQuery = await _dbContext.rawQuery(
        "SELECT * FROM ApplicationStats "
            "JOIN Applications ON "
            "ApplicationStats.ApplicationId==Applications.ID "
            "WHERE DayDate = '${dayDate.toString().substring(0,19)}'");
    List<ApplicationStat> applicationsStats = [];
    for (var element in applicationsStatsQuery) {
      applicationsStats.add(ApplicationStat.fromJson(element));
    }
    return applicationsStats;
  }
}
