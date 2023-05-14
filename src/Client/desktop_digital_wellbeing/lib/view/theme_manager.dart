import 'package:flutter/material.dart';

class ThemeManager {
  static const List<Color> greenChartPalette = [
    // Color.fromARGB(255, 165, 201, 202),
    // Color.fromARGB(255, 202, 180, 165),
    // Color.fromARGB(255, 141, 126, 116),
    // Color.fromARGB(255, 170, 170, 202),
    // Color.fromARGB(255, 119, 119, 141),
    // Color.fromARGB(255, 199, 145, 184),
    // Color.fromARGB(255, 199, 189, 145),

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
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      // primary: const Color.fromARGB(255, 73, 111, 93),
      // primary: const Color.fromARGB(105, 60, 183, 167),
      primary: const Color.fromARGB(255, 15, 138, 122),
      onPrimary: const Color.fromARGB(255, 255, 255, 255),
      secondary: const Color.fromARGB(255, 84, 83, 131),
      // secondary: const Color.fromARGB(255, 183, 79, 50),
      onSecondary: const Color.fromARGB(255, 245, 255, 245),
      error: Colors.red.shade700,
      onError: Colors.black12,
      background: const Color.fromARGB(130, 25, 25, 25),
      onBackground: const Color.fromARGB(255, 73, 111, 93),
      surface: const Color.fromARGB(240, 44, 51, 52),
      onSurface: const Color.fromARGB(255, 73, 111, 93),
    ),
  );
}
