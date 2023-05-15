import 'dart:async';
import 'dart:io';
import 'package:desktop_digital_wellbeing/utilities/util.dart';
import 'package:desktop_digital_wellbeing/view/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:desktop_digital_wellbeing/Controller/appstats_controller.dart';
import '../model/view_models/app_stat_vm.dart';

class ApplicationsStatsChart extends StatefulWidget {
  ApplicationsStatsChart({required this.dayDate, super.key});

  DateTime dayDate;

  Function? update;

  @override
  State<ApplicationsStatsChart> createState() => _ApplicationStatsChartState();
}

class _ApplicationStatsChartState extends State<ApplicationsStatsChart> {
  // Properties
  List<AppStatViewModel> appStats = [];
  CircularChartAnnotation? circularChartAnnotation;
  int? explodeIndex;
  DoughnutSeries? chart;
  List<Image> imageIcons = [];
  CircularSeriesController? controller;

  Future<void> _loadAppsStats() async {
    this.appStats = [];
    var appStats = await AppsStatsController()
        .getApplicationsStatsOfDay(day: widget.dayDate);
    for (var element in appStats) {
      if (element.usedTime.inMinutes > 5) {
        this.appStats.add(AppStatViewModel.convert(element));
      }
    }
    this.appStats.sort((a, b) => b.minutes.compareTo(a.minutes));
    for (var element in this.appStats) {
      imageIcons.add(Image(
        image:
            FileImage(File(Util.combinePath(element.iconsPath, "Jumbo.png"))),
        fit: BoxFit.contain,
      ));
    }

    if (this.appStats.isEmpty) {
      debugPrint("loaded");
      return;
    }
    explodeIndex = 0;
    debugPrint("loaded");
  }

  _updateChart(explodeIndex) {
    if (appStats.isEmpty) {
      return;
    }
    chart = DoughnutSeries(
        name: "AppStatsChart",
        animationDuration: 1500,
        animationDelay: 0,
        onRendererCreated: (CircularSeriesController controller) {
          this.controller = controller;
        },
        selectionBehavior: SelectionBehavior(
            enable: true,
            selectedOpacity: 1,
            unselectedOpacity: 0.4,
            toggleSelection: true),
        dataLabelSettings: DataLabelSettings(
            overflowMode: OverflowMode.shift,
            labelPosition: ChartDataLabelPosition.inside,
            isVisible: true,
            textStyle: TextStyle(
              fontFamily: ThemeManager.font,
                color: ThemeManager
                    .applicationCurrentTheme.colorScheme.onPrimary)),
        dataSource: appStats,
        innerRadius: '70%',
        explode: false,
        xValueMapper: (data, _) => data.usedTime,
        pointRadiusMapper: (_, i) {
          if (i == explodeIndex) {
            return "100%";
          } else {
            return "85%";
          }
        },
        dataLabelMapper: (data, _) => data.title,
        yValueMapper: (data, _) => (data.minutes));
    this.explodeIndex = explodeIndex;
    setState(() {});
    debugPrint("update chart");
  }

  _updateChartAnnotation(appStatIndex) {
    if (appStats.isEmpty) {
      circularChartAnnotation = CircularChartAnnotation(
          horizontalAlignment: ChartAlignment.center,
          height: "100%",
          width: "80%",
          verticalAlignment: ChartAlignment.center,
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                child: Text(
                  textAlign: TextAlign.center,
                  "You've not done any impressive activity on your computer",
                  style: TextStyle(
                      color: ThemeManager
                          .applicationCurrentTheme.colorScheme.onPrimary,
                      fontSize: 28),
                ),
              )
            ],
          ));
    } else {
      circularChartAnnotation = CircularChartAnnotation(
          horizontalAlignment: ChartAlignment.center,
          height: "100%",
          width: "45%",
          verticalAlignment: ChartAlignment.center,
          widget: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                imageIcons[appStatIndex],
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 12, 5, 12),
                  child: Text(
                    appStats[appStatIndex].usedTime,
                    style: TextStyle(
                        color: ThemeManager
                            .applicationCurrentTheme.colorScheme.onPrimary,
                        fontSize: 27),
                  ),
                )
              ],
            ),
          ));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadAppsStats().then((_) {
      _updateChart(explodeIndex);
      _updateChartAnnotation(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("chart is null : ${(chart == null)}");
    debugPrint("building appStats chart");
    return Container(
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
              color: ThemeManager.applicationCurrentTheme.colorScheme.primary
                  .withAlpha(210),
              blurRadius: 70,
              spreadRadius: 0.3,
              blurStyle: BlurStyle.outer)
        ]),
        child: SfCircularChart(
          palette: ThemeManager.currentChartPalette,
          onSelectionChanged: (point) {
            setState(() {
              _updateChartAnnotation(point.pointIndex);
              _updateChart(point.pointIndex);
            });
          },
          annotations: [
            CircularChartAnnotation(
                width: "97%",
                height: "97%",
                widget: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(colors: [
                      // Color.fromARGB(200, 70, 193, 157),
                      // Color.fromARGB(110, 70, 193, 157),
                      // Color.fromARGB(40, 70, 193, 157),

                      ThemeManager.applicationCurrentTheme.colorScheme.primary
                          .withAlpha(215),
                      ThemeManager.applicationCurrentTheme.colorScheme.primary
                          .withAlpha(155),
                      ThemeManager.applicationCurrentTheme.colorScheme.primary
                          .withAlpha(95),
                    ], radius: 0.5),
                    color: ThemeManager
                        .applicationCurrentTheme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                )),
            circularChartAnnotation ?? CircularChartAnnotation(),
          ],
          series: [
            chart ??
                DoughnutSeries(
                    dataSource: [],
                    xValueMapper: (data, _) => data.usedTime,
                    yValueMapper: (data, _) => (data.minutes))
          ],
        ));
  }
}
