import 'package:desktop_digital_wellbeing/controller/applications_controller.dart';
import 'package:desktop_digital_wellbeing/view/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/view_models/appusage_lastweek_vm.dart';
import 'theme_manager.dart';

class AppUsageChart extends StatefulWidget {
  const AppUsageChart({super.key});

  @override
  createState() => _AppUsageChart();
}

class _AppUsageChart extends State<AppUsageChart> {
  List<AppUsageStatViewModel> appUsageStats = [];
  AppUsageStatViewModel? selectedApp;

  void _load() async {
    appUsageStats = [];
    var apps = await ApplicationsController().getAppsIncludeStats();
    for (int i = 0; i < apps.length; i++) {
      debugPrint(apps[i].usageSum.toString());
      if (apps[i].usageSum > 0.25) {
        apps[i]
            .dailyUsageHistory
            .sort((a, b) => b.day.dayDate.compareTo(a.day.dayDate));
        appUsageStats.add(apps[i]);
      }
    }
    appUsageStats.sort((a, b) => b.usageSum.compareTo(a.usageSum));
    selectedApp = appUsageStats[0];
    setState(() {});
  }

  void _updateChart() {}

  @override
  void initState() {
    _load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            ThemeManager.applicationCurrentTheme.colorScheme.background,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SideBar(selectedItemIndex: 1),
            Expanded(
                child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SfCartesianChart(
                    series: [
                      LineSeries(
                          xValueMapper: (data, _) =>
                              DateFormat.MMMMEEEEd().format(data.day.dayDate),
                          dataSource: selectedApp?.dailyUsageHistory
                                  .take(7)
                                  .toList()
                                  .reversed
                                  .toList() ??
                              [],
                          color: ThemeManager
                              .applicationCurrentTheme.colorScheme.primary,
                          dataLabelMapper: (data, _) => data.label,
                          yValueMapper: (data, _) => data.usageSum * 60)
                    ],
                    tooltipBehavior: TooltipBehavior(
                        enable: true,
                        borderWidth: 2,
                        opacity: 0.6,
                        color: ThemeManager
                            .applicationCurrentTheme.colorScheme.secondary,
                        builder: (data, point, series, pointIndex,
                                seriesIndex) =>
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                color: Colors.transparent,
                                height: 70,
                                width: 140,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(selectedApp!.shortName,
                                        maxLines: 1,
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: ThemeManager
                                                .applicationCurrentTheme
                                                .colorScheme
                                                .onSecondary)),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              width: 0.5,
                                              color: ThemeManager
                                                  .applicationCurrentTheme
                                                  .colorScheme
                                                  .primary,
                                              style: BorderStyle.solid)),
                                    ),
                                    Text(
                                      "${data.label}  |  ${DateFormat.EEEE().format(data.day.dayDate)}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ThemeManager
                                              .applicationCurrentTheme
                                              .colorScheme
                                              .onSecondary),
                                    )
                                  ],
                                ))),
                    primaryYAxis: NumericAxis(
                        axisLine: AxisLine(
                            color: ThemeManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        majorGridLines: MajorGridLines(
                            color: ThemeManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        minorGridLines: MinorGridLines(
                            color: ThemeManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        minorTickLines: MinorTickLines(
                            color: ThemeManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        majorTickLines: MajorTickLines(
                            color: ThemeManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        labelStyle: TextStyle(
                            fontFamily: ThemeManager.font,
                            color: ThemeManager.applicationCurrentTheme
                                .colorScheme.onPrimary)),
                    primaryXAxis: CategoryAxis(
                        axisLine: AxisLine(
                            color: ThemeManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        majorGridLines: MajorGridLines(
                            color: ThemeManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        minorGridLines: MinorGridLines(
                            color: ThemeManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        minorTickLines: MinorTickLines(
                            color: ThemeManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        majorTickLines: MajorTickLines(
                            color: ThemeManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        labelStyle: TextStyle(
                            fontFamily: ThemeManager.font,
                            color: ThemeManager.applicationCurrentTheme
                                .colorScheme.onPrimary)),
                  ),
                  DropdownButton2(
                    buttonStyleData: ButtonStyleData(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: ThemeManager
                                .applicationCurrentTheme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(7))),
                    selectedItemBuilder: (context) {
                      return appUsageStats.map(
                        (app) {
                          return Container(
                            alignment: AlignmentDirectional.center,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              app.shortName,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          );
                        },
                      ).toList();
                    },
                    hint: const Text("Select Item"),
                    dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: ThemeManager.applicationCurrentTheme
                                .colorScheme.secondary)),
                    underline: Container(),
                    value: selectedApp,
                    items: appUsageStats.map((e) {
                      return DropdownMenuItem(
                        alignment: AlignmentDirectional.center,
                        enabled: true,
                        value: e,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: ThemeManager
                                          .applicationCurrentTheme
                                          .colorScheme
                                          .background))),
                          child: Center(
                            child: Text(e.shortName),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (AppUsageStatViewModel? app) {
                      setState(() {
                        selectedApp = app!;
                        _updateChart();
                      });
                    },
                  )
                ],
              ),
            ))
          ],
        ));
  }
}
