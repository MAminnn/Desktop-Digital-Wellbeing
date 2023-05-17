import 'dart:async';
import 'dart:ffi';
import 'package:desktop_digital_wellbeing/View/main.dart';
import 'package:desktop_digital_wellbeing/controller/days_controller.dart';
import 'package:desktop_digital_wellbeing/model/view_models/day_vm.dart';
import 'package:desktop_digital_wellbeing/view/ui_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DaysChart extends StatefulWidget {
  DaysChart(
      {super.key,
      required this.updateDayCallback,
      required this.updateWeekCallback,
      required this.offsetDays});

  Function updateDayCallback;
  Function updateWeekCallback;
  int offsetDays;

  @override
  State<StatefulWidget> createState() => _DaysChartState();
}

class _DaysChartState extends State<DaysChart> {
  List<DayViewModel> days = [];
  ColumnSeries<DayViewModel, dynamic>? chart;
  DateTime firstDay = DateTime(0);

  _updateChart(int selectedDayIndex) {
    chart = ColumnSeries<DayViewModel, dynamic>(
        initialSelectedDataIndexes: [6],
        dataLabelMapper: (data, _) => data.label,
        dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(
                color:
                    UIManager.applicationCurrentTheme.colorScheme.onPrimary)),
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
    days = [];
    firstDay = (await DaysController().getFirstDay()).dayDate;
    for (int i = count - 1; i >= 0; i--) {
      var day = await DaysController().getDayOrDefault(
          dayDate: DateTime.now().add(Duration(days: -i - offset)));
      days.add(DayViewModel.fromDay(day: day));
    }
  }

  @override
  void initState() {
    _loadDays(7, widget.offsetDays).then((value) => _updateChart(6));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              var now = DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day);
              if (now
                  .add(Duration(days: -(widget.offsetDays + 14)))
                  .isAfter(firstDay)) {
                widget.offsetDays += 7;
              } else {
                debugPrint(now
                    .add(Duration(days: -(widget.offsetDays + 7)))
                    .day
                    .toString());
                debugPrint(firstDay.day.toString());
                int distance = now
                    .add(Duration(days: -(widget.offsetDays + 7)))
                    .difference(firstDay)
                    .inDays;
                if (distance < 7) {
                  debugPrint(distance.toString());
                  widget.offsetDays += distance + 1;
                } else {
                  return;
                }
              }
              widget.updateWeekCallback(widget.offsetDays);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: UIManager.applicationCurrentTheme.colorScheme.primary,
            )),
        Expanded(
            child: SfCartesianChart(
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
                  color:
                      UIManager.applicationCurrentTheme.colorScheme.tertiary),
              majorGridLines: MajorGridLines(
                  color:
                      UIManager.applicationCurrentTheme.colorScheme.tertiary),
              minorGridLines: MinorGridLines(
                  color:
                      UIManager.applicationCurrentTheme.colorScheme.tertiary),
              minorTickLines: MinorTickLines(
                  color:
                      UIManager.applicationCurrentTheme.colorScheme.tertiary),
              majorTickLines: MajorTickLines(
                  color:
                      UIManager.applicationCurrentTheme.colorScheme.tertiary),
              labelStyle: TextStyle(
                  fontFamily: UIManager.font,
                  color:
                      UIManager.applicationCurrentTheme.colorScheme.onPrimary)),
          primaryXAxis: CategoryAxis(
              axisLine: AxisLine(
                  color:
                      UIManager.applicationCurrentTheme.colorScheme.tertiary),
              majorGridLines: MajorGridLines(
                  color:
                      UIManager.applicationCurrentTheme.colorScheme.tertiary),
              minorGridLines: MinorGridLines(
                  color:
                      UIManager.applicationCurrentTheme.colorScheme.tertiary),
              minorTickLines: MinorTickLines(
                  color:
                      UIManager.applicationCurrentTheme.colorScheme.tertiary),
              majorTickLines: MajorTickLines(
                  color:
                      UIManager.applicationCurrentTheme.colorScheme.tertiary),
              visibleMaximum: 6,
              maximum: 6,
              labelStyle: TextStyle(
                  fontFamily: UIManager.font,
                  color:
                      UIManager.applicationCurrentTheme.colorScheme.onPrimary)),
          series: chart != null
              ? [chart as ColumnSeries<DayViewModel, dynamic>]
              : <ColumnSeries<DayViewModel, dynamic>>[],
        )),
        IconButton(
          onPressed: () {
            if (widget.offsetDays < 1) {
              return;
            }
            var now = DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day);
            if (widget.offsetDays >= 7) {
              widget.offsetDays -= 7;
            } else {
              widget.offsetDays = 0;
            }
            widget.updateWeekCallback(widget.offsetDays);
          },
          icon: Icon(Icons.arrow_forward_ios_rounded,
              color: UIManager.applicationCurrentTheme.colorScheme.primary),
        )
      ],
    );
  }
}
