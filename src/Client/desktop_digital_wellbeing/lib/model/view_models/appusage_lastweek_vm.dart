import 'dart:io';

import 'package:desktop_digital_wellbeing/model/view_models/day_vm.dart';

import '../../utilities/util.dart';
import './app_stat_vm.dart';

class AppUsageStatViewModel {
  String id;
  double usageSum;
  String path;
  String shortName;
  List<DayViewModel> dailyUsageHistory;

  String getIconPath() {
    return Util.combinePath(Util.combinePath(
        Util.combinePath(
            Directory(Platform.resolvedExecutable).parent.path, "icons"),
        id), "Jumbo.png");
  }

  AppUsageStatViewModel(
      {required this.id,
      required this.usageSum,
      required this.dailyUsageHistory,
      required this.path,
      required this.shortName});
}
