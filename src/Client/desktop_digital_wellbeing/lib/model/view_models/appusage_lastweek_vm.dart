import 'package:desktop_digital_wellbeing/model/view_models/day_vm.dart';

import './app_stat_vm.dart';

class AppUsageStatViewModel {
  String id;
  double usageSum;
  String path;
  String shortName;
  List<DayViewModel> dailyUsageHistory;

  AppUsageStatViewModel(
      {required this.id,
      required this.usageSum,
      required this.dailyUsageHistory,
      required this.path,
      required this.shortName});


}
