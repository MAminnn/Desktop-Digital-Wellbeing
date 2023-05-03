import 'dart:io';
import 'package:desktop_digital_wellbeing/utilities/util.dart';
import 'package:desktop_digital_wellbeing/view/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:desktop_digital_wellbeing/Controller/appstat_controller.dart';
import '../model/view_models/app_stat_presenter.dart';

class ApplicationsStatsChart extends StatefulWidget {
  const ApplicationsStatsChart({super.key});

  @override
  State<ApplicationsStatsChart> createState() => _ApplicationStatsChartState();
}

class _ApplicationStatsChartState extends State<ApplicationsStatsChart>
    with TickerProviderStateMixin {
  // Properties
  List<AppStatPresenter> appStats = [];
  CircularChartAnnotation? circularChartAnnotation;
  int? explodeIndex;
  DoughnutSeries? chart;
  List<Image> imageIcons = [];

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  _loadAppsStats() {
    AppsStatsController().getApplicationsStats().then((appStats) {
      setState(() {
        for (var element in appStats) {
          var appStatPresenter = AppStatPresenter.convert(element);

          if (appStatPresenter != null) {
            this.appStats.add(appStatPresenter);
          }
        }
        this.appStats.sort((a, b) => b.minutes.compareTo(a.minutes));
        for (var element in this.appStats) {
          imageIcons.add(Image(
            image: FileImage(
                File(Util.combinePath(element.iconsPath, "Jumbo.png"))),
            fit: BoxFit.contain,
          ));
        }

        explodeIndex = 0;
        _updateChartAnnotation(
            this.appStats[0].usedTime, this.appStats[0].title, imageIcons[0]);
      });
    });
  }

  _updateChart(explodeIndex) {
    chart = DoughnutSeries(
        name: "AppStatsChart",
        animationDuration: 2000,
        animationDelay: 0,
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
                color:
                    ThemeManager.applicationDarkTheme.colorScheme.onPrimary)),
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
  }

  _updateChartAnnotation(String usedTime, String path, Image img) =>
      circularChartAnnotation = CircularChartAnnotation(
          horizontalAlignment: ChartAlignment.center,
          height: "100%",
          width: "45%",
          verticalAlignment: ChartAlignment.center,
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              img,
              Container(
                padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                child: Text(
                  usedTime,
                  style: TextStyle(
                      color: ThemeManager
                          .applicationDarkTheme.colorScheme.onPrimary,
                      fontSize: 27),
                ),
              )
            ],
          ));

  @override
  void initState() {
    _loadAppsStats();
    _updateChart(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
              color: ThemeManager.applicationDarkTheme.colorScheme.primary,
              blurRadius: 60,
              spreadRadius: 0.3,
              blurStyle: BlurStyle.outer)
        ]),
        child: SfCircularChart(
          palette: ThemeManager.greenChartPalette,
          onSelectionChanged: (point) {
            setState(() {
              _updateChartAnnotation(
                  appStats[point.pointIndex].usedTime,
                  appStats[point.pointIndex].title,
                  imageIcons[point.pointIndex]);
              _updateChart(point.pointIndex);
            });
          },
          annotations: [
            CircularChartAnnotation(
                width: "97%",
                height: "97%",
                widget: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const RadialGradient(colors: [
                      Color.fromARGB(200, 70, 193, 157),
                      Color.fromARGB(110, 70, 193, 157),
                      Color.fromARGB(40, 70, 193, 157),
                    ], radius: 0.5),
                    color:
                        ThemeManager.applicationDarkTheme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                )),
            circularChartAnnotation ?? CircularChartAnnotation(),
          ],
          tooltipBehavior: TooltipBehavior(
              header: 'Today Used Time',
              format: "point.x",
              enable: false,
              activationMode: ActivationMode.longPress),
          series: [chart!],
        ));
  }
}
