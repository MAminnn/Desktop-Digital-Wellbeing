import 'package:desktop_digital_wellbeing/View/days_chart.dart';
import 'package:desktop_digital_wellbeing/utilities/startup.dart';
import 'package:desktop_digital_wellbeing/view/charts_contaienr.dart';
import 'package:desktop_digital_wellbeing/view/sidebar.dart';
import 'package:desktop_digital_wellbeing/view/theme_layout.dart';
import 'package:desktop_digital_wellbeing/view/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'appusage_chart.dart';

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
          '/AppUsageChart': (context) => const AppUsageChart()
        },
        title: 'Desktop Digital Wellbeing',
        theme: ThemeManager.applicationCurrentTheme,
        home: Scaffold(
            backgroundColor:
                ThemeManager.applicationCurrentTheme.colorScheme.background,
            body: const ThemeLayout()));
  }
}
