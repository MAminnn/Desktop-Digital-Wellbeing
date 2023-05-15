import 'package:desktop_digital_wellbeing/view/theme_manager.dart';
import 'package:flutter/material.dart';
import 'appstat_chart.dart';
import 'days_chart.dart';
import 'main.dart';

class ChartsContainer extends StatefulWidget {
  ChartsContainer({super.key, required this.updateThemeCallback});

  Function updateThemeCallback;

  @override
  createState() => _ChartsContainer();
}

class _ChartsContainer extends State<ChartsContainer> {
  DateTime day = DateTime.now();
  Function? updateDay;
  Key appStatsKey = Key(DateTime.now().toString());

  @override
  void initState() {
    updateDay = (DateTime dayDate) {
      setState(() {
        day = dayDate;
        appStatsKey = Key(dayDate.toString());
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            flex: 1,
            child: DaysChart(
              updateDayCallback: updateDay!,
            )),
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          appStatsKey = UniqueKey();
                        });
                      },
                      icon: Icon(
                        Icons.refresh,
                        color: ThemeManager
                            .applicationCurrentTheme.colorScheme.primary,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widget.updateThemeCallback.call(
                              ThemeManager.applicationLightTheme,
                              ThemeManager.lightChartPalette);
                        });
                      },
                      icon: Icon(
                        Icons.circle,
                        color: ThemeManager
                            .applicationLightTheme.colorScheme.primary,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widget.updateThemeCallback.call(
                              ThemeManager.applicationDarkTheme,
                              ThemeManager.greenChartPalette);
                        });
                      },
                      icon: Icon(
                        Icons.circle,
                        color: ThemeManager
                            .applicationDarkTheme.colorScheme.primary,
                      )),
                  Expanded(
                      child: ApplicationsStatsChart(
                    dayDate: day,
                    key: appStatsKey,
                  ))
                ],
              ),
            )),
      ],
    );
  }
}
