import 'package:desktop_digital_wellbeing/model/entities/day.dart';

class DayViewModel {
  Day day;
  double usageSum;
  String label;

  DayViewModel(
      {required this.day, required this.usageSum, required this.label});

  factory DayViewModel.fromDay({required Day day}) {
    double usageSum = 0;
    for (var appSat in day.applicationStats) {
      usageSum += appSat.usedTime.inSeconds;
    }
    var totalDuration = Duration(seconds: usageSum.toInt());
    String label = "";
    if (totalDuration.inMinutes < 60) {
      label = "${totalDuration.inMinutes}m";
    } else {
      label = "${(totalDuration.inMinutes / 60).toStringAsFixed(1)}h";
    }
    usageSum = (Duration(seconds: usageSum.toInt()).inMinutes / 60);
    return DayViewModel(day: day, usageSum: usageSum, label: label);
  }
}
