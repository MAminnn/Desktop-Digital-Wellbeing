import 'package:desktop_digital_wellbeing/model/entities/day.dart';
import 'package:desktop_digital_wellbeing/utilities/startup.dart';
import 'package:desktop_digital_wellbeing/view/sidebar.dart';
import 'package:desktop_digital_wellbeing/view/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:desktop_digital_wellbeing/View/appstat_chart.dart';
import 'package:window_size/window_size.dart';
import 'package:desktop_digital_wellbeing/View/appstat_chart.dart';
import 'days_chart.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  setWindowMinSize(const Size(1280, 960));
  await Startup().setup();
}

void main() {
  init().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desktop Digital Wellbeing',
      theme: ThemeManager.applicationDarkTheme,
      home: Scaffold(
          body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            color: ThemeManager.applicationDarkTheme.colorScheme.background,
            child: const SideBar(),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              color: ThemeManager.applicationDarkTheme.colorScheme.background,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // const Expanded(flex: 1, child: DaysChart()),
                  Expanded(
                    flex: 5,
                    child: Center(
                        child: ApplicationsStatsChart(
                      dayDate: DateTime.now().add(const Duration(days: -3)),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
