import 'dart:io';

import 'package:desktop_digital_wellbeing/model/entities/application_stat.dart';

import '../../utilities/util.dart';

class AppStatViewModel {
  AppStatViewModel();

  late int minutes;
  late String usedTime;
  late String title;
  late String iconsPath;
  late String id;

  static AppStatViewModel convert(ApplicationStat appStat) {
    var p = AppStatViewModel();
    p.minutes = appStat.usedTime.inMinutes;
    if (p.minutes < 60) {
      p.usedTime = "${p.minutes}m";
    } else {
      p.usedTime = "${(p.minutes / 60).toStringAsFixed(1)}h";
    }
    p.title = appStat.application!.path
        .split("\\")
        .last
        .replaceAll(".EXE", "")
        .replaceAll(".exe", "");
    p.iconsPath = Util.combinePath(
        Util.combinePath(
            Directory(Platform.resolvedExecutable).parent.path, "icons"),
        appStat.application!.id);
    p.id = appStat.application!.id;
    return p;
  }
}
