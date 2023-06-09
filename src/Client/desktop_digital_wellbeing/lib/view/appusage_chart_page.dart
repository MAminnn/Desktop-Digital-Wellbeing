import 'dart:io';

import 'package:desktop_digital_wellbeing/controller/applications_controller.dart';
import 'package:desktop_digital_wellbeing/view/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/view_models/appusage_lastweek_vm.dart';
import '../utilities/util.dart';
import 'ui_manager.dart';

class AppUsageChartPage extends StatefulWidget {
  const AppUsageChartPage({super.key});

  @override
  createState() => _AppUsageChartPage();
}

class _AppUsageChartPage extends State<AppUsageChartPage> {
  List<AppUsageStatViewModel> appUsageStats = [];
  AppUsageStatViewModel? selectedApp;
  Widget selectedAppIcon = Center();

  void _load() async {
    appUsageStats = [];
    var apps = await ApplicationsController().getAppsIncludeStats();
    for (int i = 0; i < apps.length; i++) {
      if (apps[i].usageSum > 0.25) {
        apps[i]
            .dailyUsageHistory
            .sort((a, b) => b.day.dayDate.compareTo(a.day.dayDate));
        appUsageStats.add(apps[i]);
      }
    }
    appUsageStats.sort((a, b) => b.usageSum.compareTo(a.usageSum));
    selectedApp = appUsageStats[0];
    selectedAppIcon = Center(
      child: Image.file(File(selectedApp!.getIconPath()), width: 200),
    );
    setState(() {});
  }

  void _updateChart() {
    selectedAppIcon = Center(
      child: Image.file(File(selectedApp!.getIconPath()), width: 200),
    );
  }

  @override
  void initState() {
    _load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            UIManager.applicationCurrentTheme.colorScheme.background,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SideBar(selectedItemIndex: 1),
            Expanded(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          color: UIManager
                              .applicationCurrentTheme.colorScheme.primary,
                          dataLabelMapper: (data, _) => data.label,
                          yValueMapper: (data, _) => data.usageSum * 60)
                    ],
                    tooltipBehavior: TooltipBehavior(
                        enable: true,
                        borderWidth: 2,
                        opacity: 0.6,
                        color: UIManager
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
                                            color: UIManager
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
                                              color: UIManager
                                                  .applicationCurrentTheme
                                                  .colorScheme
                                                  .primary,
                                              style: BorderStyle.solid)),
                                    ),
                                    Text(
                                      "${data.label}  |  ${DateFormat.EEEE().format(data.day.dayDate)}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: UIManager
                                              .applicationCurrentTheme
                                              .colorScheme
                                              .onSecondary),
                                    )
                                  ],
                                ))),
                    primaryYAxis: NumericAxis(
                        axisLine: AxisLine(
                            color: UIManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        majorGridLines: MajorGridLines(
                            color: UIManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        minorGridLines: MinorGridLines(
                            color: UIManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        minorTickLines: MinorTickLines(
                            color: UIManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        majorTickLines: MajorTickLines(
                            color: UIManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        labelStyle: TextStyle(
                            fontFamily: UIManager.font,
                            color: UIManager.applicationCurrentTheme.colorScheme
                                .onPrimary)),
                    primaryXAxis: CategoryAxis(
                        axisLine: AxisLine(
                            color: UIManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        majorGridLines: MajorGridLines(
                            color: UIManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        minorGridLines: MinorGridLines(
                            color: UIManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        minorTickLines: MinorTickLines(
                            color: UIManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        majorTickLines: MajorTickLines(
                            color: UIManager
                                .applicationCurrentTheme.colorScheme.tertiary),
                        labelStyle: TextStyle(
                            fontFamily: UIManager.font,
                            color: UIManager.applicationCurrentTheme.colorScheme
                                .onPrimary)),
                  ),
                  DropdownButton2(
                    buttonStyleData: ButtonStyleData(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: UIManager
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
                            color: UIManager.applicationCurrentTheme.colorScheme
                                .secondary)),
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
                                      color: UIManager.applicationCurrentTheme
                                          .colorScheme.background))),
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
                  ),
                  selectedAppIcon
                ],
              ),
            ))
          ],
        ));
  }
}
