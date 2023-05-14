import 'dart:async';

import 'package:desktop_digital_wellbeing/model/entities/application_stat.dart';
import 'package:desktop_digital_wellbeing/model/entities/day.dart';
import 'package:desktop_digital_wellbeing/view/theme_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Controller/appstats_controller.dart';
import 'appstat_chart.dart';
import 'days_chart.dart';

class ChartsContainer extends StatefulWidget {
  const ChartsContainer({super.key});

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
                          .applicationDarkTheme.colorScheme.primary,
                    )),
                Expanded(
                    child: ApplicationsStatsChart(
                  dayDate: day,
                  key: appStatsKey,
                ))
              ],
            )),
      ],
    );
  }
}
