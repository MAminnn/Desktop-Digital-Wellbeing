import 'package:desktop_digital_wellbeing/model/entities/application.dart';
import 'package:desktop_digital_wellbeing/model/entities/application_stat.dart';
import 'package:desktop_digital_wellbeing/model/entities/day.dart';
import 'package:desktop_digital_wellbeing/model/view_models/app_stat_vm.dart';
import 'package:desktop_digital_wellbeing/model/view_models/appusage_lastweek_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../model/database_context/database_context.dart';
import '../model/view_models/day_vm.dart';

class ApplicationsController {
  late Database _dbContext;

  ApplicationsController() {
    _dbContext = DbContext().db;
  }

  Future<List<Application>> getApplications() async {
    return (await DbContext().db.query("Applications"))
        .map((app) => Application.fromQuery(app))
        .toList();
  }

  Future<List<AppUsageStatViewModel>> getAppsIncludeStats() async {
    List<AppUsageStatViewModel> appUsageStats = [];
    String query = "SELECT * FROM Applications app INNER JOIN"
        " ApplicationStats applicationStat ON "
        "app.ID == applicationStat.ApplicationId ORDER BY app.ID";
    var apps = await DbContext().db.rawQuery(query);
    for (int i = 0; i < apps.length;) {
      if (appUsageStats.any((element) => element.id == apps[i]['ID'])) {
        var day = Day.fromQuery(apps[i]);
        int b = i;
        while (DateTime.parse(apps[b]['DayDate'].toString()) == day.dayDate) {
          day.applicationStats
              .add(ApplicationStat.fromQueryIncludeDay(apps[b]));
          b++;
          if (b == apps.length) {
            break;
          }
        }
        var dayVM = DayViewModel.fromDay(day: day);
        appUsageStats
            .firstWhere((element) => element.id == apps[i]['ID'])
            .dailyUsageHistory
            .add(dayVM);
        appUsageStats
            .firstWhere((element) => element.id == apps[i]['ID'])
            .usageSum += dayVM.usageSum;
        i++;
      } else {
        appUsageStats.add(AppUsageStatViewModel(
            id: apps[i]['ID'].toString(),
            usageSum: 0,
            dailyUsageHistory: [],
            path: apps[i]['Path'].toString(),
            shortName: apps[i]['Path']
                .toString()
                .split("\\")
                .last
                .replaceAll(".EXE", "")
                .replaceAll(".exe", "")));
      }
    }
    return appUsageStats;
  }
}
