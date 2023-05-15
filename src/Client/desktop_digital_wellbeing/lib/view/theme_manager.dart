import 'package:flutter/material.dart';

class ThemeManager {

  static const String font = 'AcmeRegular';

  static const List<Color> greenChartPalette = [
    Color.fromARGB(255, 20, 160, 102),
    Color.fromARGB(255, 66, 75, 84),
    Color.fromARGB(255, 34, 116, 165),
    Color.fromARGB(255, 91, 80, 122),
    Color.fromARGB(255, 71, 88, 65),
    Color.fromARGB(255, 214, 64, 69),
    Color.fromARGB(255, 4, 42, 43),
    Color.fromARGB(255, 0, 79, 45),
    Color.fromARGB(255, 45, 48, 71),
  ];
  static const List<Color> creamChartPalette = [
    Color.fromARGB(255, 165, 201, 202),
    Color.fromARGB(255, 202, 180, 165),
    Color.fromARGB(255, 141, 126, 116),
    Color.fromARGB(255, 170, 170, 202),
    Color.fromARGB(255, 119, 119, 141),
    Color.fromARGB(255, 199, 145, 184),
    Color.fromARGB(255, 199, 189, 145),
  ];
  static const List<Color> lightChartPalette = [
    Color.fromARGB(255, 246, 116, 95),
    Color.fromARGB(255, 115, 102, 120),
    Color.fromARGB(255, 206, 193, 165),
    Color.fromARGB(255, 254, 228, 131),
    Color.fromARGB(255, 248, 183, 151),
    Color.fromARGB(255, 228, 215, 197),
  ];
  static const List<Color> deadChartPalette = [
    Color.fromARGB(255, 185, 167, 150),
    Color.fromARGB(255, 91, 91, 89),
    Color.fromARGB(255, 204, 99, 88),
    Color.fromARGB(255, 149, 169, 158),
    Color.fromARGB(255, 205, 213, 211),
    Color.fromARGB(255, 101, 142, 103),
    Color.fromARGB(255, 232, 219, 221),
    Color.fromARGB(255, 106, 154, 142),
  ];

  static final ThemeData applicationDarkTheme = ThemeData(
    fontFamily: 'AcmeRegular',
    colorScheme: ColorScheme(
      tertiary: const Color.fromARGB(135, 175, 173, 175),
      brightness: Brightness.dark,
      primary: const Color.fromARGB(255, 15, 138, 122),
      onPrimary: const Color.fromARGB(255, 255, 255, 255),
      secondary: const Color.fromARGB(255, 84, 83, 131),
      onSecondary: const Color.fromARGB(255, 245, 255, 245),
      error: Colors.red.shade700,
      onError: Colors.black12,
      background: const Color.fromARGB(250, 40, 40, 40),
      onBackground: const Color.fromARGB(255, 73, 111, 93),
      surface: const Color.fromARGB(240, 44, 51, 52),
      onSurface: const Color.fromARGB(255, 73, 111, 93),
    ),
  );
  static final ThemeData applicationLightTheme = ThemeData(
    fontFamily: 'AcmeRegular',
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      tertiary: const Color.fromARGB(55, 255, 83, 85),
      primary: const Color.fromARGB(255, 255, 0, 53),
      onPrimary: const Color.fromARGB(255, 30, 30, 33),
      secondary: const Color.fromARGB(255, 236, 164, 0),
      onSecondary: const Color.fromARGB(255, 245, 255, 245),
      error: Colors.red.shade700,
      onError: Colors.black12,
      background: const Color.fromARGB(235, 230, 230, 233),
      onBackground: const Color.fromARGB(255, 0, 129, 167),
      surface: const Color.fromARGB(255, 205, 205, 208),
      onSurface: const Color.fromARGB(255, 30, 30, 33),
    ),
  );

  static ThemeData applicationCurrentTheme = applicationDarkTheme;
  static List<Color> currentChartPalette = greenChartPalette;
}
