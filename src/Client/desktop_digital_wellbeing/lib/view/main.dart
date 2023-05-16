import 'package:desktop_digital_wellbeing/View/days_chart.dart';
import 'package:desktop_digital_wellbeing/utilities/startup.dart';
import 'package:desktop_digital_wellbeing/view/aboutus.dart';
import 'package:desktop_digital_wellbeing/view/charts_contaienr.dart';
import 'package:desktop_digital_wellbeing/view/sidebar.dart';
import 'package:desktop_digital_wellbeing/view/theme_layout.dart';
import 'package:desktop_digital_wellbeing/view/ui_manager.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'appusage_chart_page.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  setWindowMinSize(const Size(1600, 900));
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
          '/AboutUs': (context) => const AboutUsPage(),
          '/AppUsageChart': (context) => const AppUsageChartPage()
        },
        title: 'Desktop Digital Wellbeing',
        theme: UIManager.applicationCurrentTheme,
        home: Scaffold(
            backgroundColor:
                UIManager.applicationCurrentTheme.colorScheme.background,
            body: const ThemeLayout()));
  }
}
