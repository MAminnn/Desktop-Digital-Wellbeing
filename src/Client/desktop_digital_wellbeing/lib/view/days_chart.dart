import 'dart:async';

import 'package:desktop_digital_wellbeing/controller/days_controller.dart';
import 'package:desktop_digital_wellbeing/model/view_models/day_vm.dart';
import 'package:desktop_digital_wellbeing/view/theme_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/entities/day.dart';

class DaysChart extends StatefulWidget {
  const DaysChart({super.key});

  @override
  State<StatefulWidget> createState() => _DaysChartState();
}

class _DaysChartState extends State<DaysChart> {
  List<DayViewModel> days = [];
  ColumnSeries<DayViewModel, dynamic>? chart;

  void updateChart(int selectedDayIndex) {
    chart = ColumnSeries<DayViewModel, dynamic>(
        initialSelectedDataIndexes: [0],
        color: ThemeManager.applicationDarkTheme.colorScheme.secondary,
        dataLabelMapper: (data, _) => data.label,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        selectionBehavior: SelectionBehavior(
          enable: true,
        ),
        dataSource: days,
        pointColorMapper: (_, i) => i == selectedDayIndex
            ? ThemeManager.applicationDarkTheme.colorScheme.primary
            : ThemeManager.applicationDarkTheme.colorScheme.secondary,
        xValueMapper: (data, _) =>
            DateFormat.MMMMEEEEd().format(data.day.dayDate),
        yValueMapper: (data, _) => data.usageSum);
  }

  Future<void> loadDays(int count, int offset) async {
    for (int i = count - 1; i >= 0; i--) {
      DaysController()
          .getDayOrDefault(dayDate: DateTime.now().add(Duration(days: -i)))
          .then((day) => days.add(DayViewModel.fromDay(day: day)));
    }
  }

  @override
  void initState() {
    loadDays(7, 0).then((value) {
      Timer(Duration(milliseconds: 300), () {
        setState(() {
          debugPrint("loaded");
          updateChart(0);
          debugPrint("updating");
        });
      });
    });
    debugPrint("line 57");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("building");
    return SfCartesianChart(
      enableAxisAnimation: false,
      onSelectionChanged: (point) {
        setState(() {
          updateChart(point.pointIndex);
        });
      },
      primaryYAxis: NumericAxis(visibleMaximum: 24, maximum: 24, interval: 6),
      primaryXAxis: CategoryAxis(visibleMaximum: 6, maximum: 6),
      series: chart != null
          ? [chart as ColumnSeries<DayViewModel, dynamic>]
          : <ColumnSeries<DayViewModel, dynamic>>[],
    );
  }
}
