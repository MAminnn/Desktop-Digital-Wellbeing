import 'dart:async';
import 'package:desktop_digital_wellbeing/controller/days_controller.dart';
import 'package:desktop_digital_wellbeing/model/view_models/day_vm.dart';
import 'package:desktop_digital_wellbeing/view/ui_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DaysChart extends StatefulWidget {
  DaysChart({super.key, required this.updateDayCallback});

  Function updateDayCallback;

  @override
  State<StatefulWidget> createState() => _DaysChartState();
}

class _DaysChartState extends State<DaysChart> {
  List<DayViewModel> days = [];
  ColumnSeries<DayViewModel, dynamic>? chart;

  _updateChart(int selectedDayIndex) {
    chart = ColumnSeries<DayViewModel, dynamic>(
        initialSelectedDataIndexes: [6],
        dataLabelMapper: (data, _) => data.label,
        dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(
                color: UIManager
                    .applicationCurrentTheme.colorScheme.onPrimary)),
        selectionBehavior: SelectionBehavior(
          enable: true,
        ),
        dataSource: days,
        pointColorMapper: (_, i) => i == selectedDayIndex
            ? UIManager.applicationCurrentTheme.colorScheme.primary
            : UIManager.applicationCurrentTheme.colorScheme.secondary,
        xValueMapper: (data, _) =>
            DateFormat.MMMMEEEEd().format(data.day.dayDate),
        yValueMapper: (data, _) => data.usageSum);
    setState(() {});
  }

  Future<void> _loadDays(int count, int offset) async {
    for (int i = count - 1; i >= 0; i--) {
      var day = await DaysController()
          .getDayOrDefault(dayDate: DateTime.now().add(Duration(days: -i)));
      days.add(DayViewModel.fromDay(day: day));
    }
  }

  @override
  void initState() {
    _loadDays(7, 0).then((value) => _updateChart(6));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("building days chart");
    return SfCartesianChart(
      borderColor: Colors.transparent,
      enableAxisAnimation: false,
      onSelectionChanged: (point) {
        setState(() {
          _updateChart(point.pointIndex);
          widget.updateDayCallback.call(days[point.pointIndex].day.dayDate);
        });
      },
      primaryYAxis: NumericAxis(
          visibleMaximum: 24,
          maximum: 24,
          interval: 6,
          axisLine: AxisLine(
              color: UIManager.applicationCurrentTheme.colorScheme.tertiary),
          majorGridLines: MajorGridLines(
              color: UIManager.applicationCurrentTheme.colorScheme.tertiary),
          minorGridLines: MinorGridLines(
              color: UIManager.applicationCurrentTheme.colorScheme.tertiary),
          minorTickLines: MinorTickLines(
              color: UIManager.applicationCurrentTheme.colorScheme.tertiary),
          majorTickLines: MajorTickLines(
              color: UIManager.applicationCurrentTheme.colorScheme.tertiary),
          labelStyle: TextStyle(
              fontFamily: UIManager.font,
              color:
                  UIManager.applicationCurrentTheme.colorScheme.onPrimary)),
      primaryXAxis: CategoryAxis(
          axisLine: AxisLine(
              color: UIManager.applicationCurrentTheme.colorScheme.tertiary),
          majorGridLines: MajorGridLines(
              color: UIManager.applicationCurrentTheme.colorScheme.tertiary),
          minorGridLines: MinorGridLines(
              color: UIManager.applicationCurrentTheme.colorScheme.tertiary),
          minorTickLines: MinorTickLines(
              color: UIManager.applicationCurrentTheme.colorScheme.tertiary),
          majorTickLines: MajorTickLines(
              color: UIManager.applicationCurrentTheme.colorScheme.tertiary),
          visibleMaximum: 6,
          maximum: 6,
          labelStyle: TextStyle(
              fontFamily: UIManager.font,
              color:
                  UIManager.applicationCurrentTheme.colorScheme.onPrimary)),
      series: chart != null
          ? [chart as ColumnSeries<DayViewModel, dynamic>]
          : <ColumnSeries<DayViewModel, dynamic>>[],
    );
  }
}
