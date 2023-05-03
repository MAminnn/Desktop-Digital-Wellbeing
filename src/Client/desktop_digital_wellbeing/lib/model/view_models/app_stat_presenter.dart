import 'dart:io';

import 'package:desktop_digital_wellbeing/model/entities/application_stat.dart';

import '../../utilities/util.dart';

class AppStatPresenter {
  AppStatPresenter();

  late int minutes;
  late String usedTime;
  late String title;
  late String iconsPath;
  late String id;

  static AppStatPresenter? convert(ApplicationStat appStat) {
    if (appStat.usedTime < const Duration(minutes: 5)) {
      return null;
    }
    var p = AppStatPresenter();
    p.minutes = appStat.usedTime.inMinutes;
    if (p.minutes < 60) {
      p.usedTime = "${p.minutes}m";
    } else {
      p.usedTime = "${(p.minutes / 60).toStringAsFixed(1)}h";
    }
    p.title = appStat.application.path
        .split("\\")
        .last
        .replaceAll(".EXE", "")
        .replaceAll(".exe", "");
    p.iconsPath = Util.combinePath(
        Util.combinePath(
            Directory(Platform.resolvedExecutable).parent.path, "icons"),
        appStat.application.id);
    p.id = appStat.application.id;
    return p;
  }
}
