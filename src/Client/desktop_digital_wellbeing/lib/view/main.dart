import 'package:desktop_digital_wellbeing/model/entities/day.dart';
import 'package:desktop_digital_wellbeing/utilities/startup.dart';
import 'package:desktop_digital_wellbeing/view/charts_contaienr.dart';
import 'package:desktop_digital_wellbeing/view/sidebar.dart';
import 'package:desktop_digital_wellbeing/view/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:desktop_digital_wellbeing/View/appstat_chart.dart';
import 'package:window_size/window_size.dart';
import 'package:desktop_digital_wellbeing/View/appstat_chart.dart';
import 'appusage_chart.dart';
import 'days_chart.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  setWindowMinSize(const Size(1366, 768));
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
      initialRoute: '/',
      routes: {
        // '/': (context) => const MyApp(),
        '/AppUsageChart': (context) => AppUsageChart()
      },
      title: 'Desktop Digital Wellbeing',
      theme: ThemeManager.applicationDarkTheme,
      home: Scaffold(
          body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            color: ThemeManager.applicationDarkTheme.colorScheme.background,
            child: SideBar(selectedItemIndex: 0),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              color: ThemeManager.applicationDarkTheme.colorScheme.background,
              child: const ChartsContainer(),
            ),
          ),
        ],
      )),
    );
  }
}
