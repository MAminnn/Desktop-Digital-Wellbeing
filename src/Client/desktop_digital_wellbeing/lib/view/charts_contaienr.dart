import 'package:desktop_digital_wellbeing/view/ui_manager.dart';
import 'package:flutter/material.dart';
import '../model/view_models/day_vm.dart';
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
  Function? updateWeek;
  Key appStatsKey = Key(DateTime.now().toString());
  Key daysKey = const Key("0");
  int offsetDays = 0;

  @override
  void initState() {
    updateDay = (DateTime dayDate) {
      setState(() {
        day = dayDate;
        appStatsKey = Key(dayDate.toString());
      });
    };

    updateWeek = (int offset) {
      setState(() {
        offsetDays = offset;
        daysKey = Key(offset.toString());
      });
      updateDay!(DateTime.now().add(Duration(days: -offset)));
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
              key: daysKey,
              offsetDays: offsetDays,
              updateDayCallback: updateDay!,
              updateWeekCallback: updateWeek!,
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
                        color: UIManager
                            .applicationCurrentTheme.colorScheme.primary,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widget.updateThemeCallback.call(
                              UIManager.applicationLightTheme,
                              UIManager.lightChartPalette);
                        });
                      },
                      icon: Icon(
                        Icons.circle,
                        color:
                            UIManager.applicationLightTheme.colorScheme.primary,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widget.updateThemeCallback.call(
                              UIManager.applicationDarkTheme,
                              UIManager.greenChartPalette);
                        });
                      },
                      icon: Icon(
                        Icons.circle,
                        color:
                            UIManager.applicationDarkTheme.colorScheme.primary,
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
