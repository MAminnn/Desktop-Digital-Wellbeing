import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'charts_contaienr.dart';
import 'sidebar.dart';
import 'ui_manager.dart';

class ThemeLayout extends StatefulWidget {
  const ThemeLayout({super.key});

  @override
  createState() => _ThemeLayout();
}

class _ThemeLayout extends State<ThemeLayout> {
  void test() {}

  Key updateKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            decoration: BoxDecoration(
                color:
                    UIManager.applicationCurrentTheme.colorScheme.background,
                border: Border.all(color: Colors.transparent)),
            child: SideBar(
              selectedItemIndex: 0,
              key: updateKey,
            )),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
                color:
                    UIManager.applicationCurrentTheme.colorScheme.background,
                border: const Border.fromBorderSide(
                    BorderSide(color: Colors.transparent))),
            child: ChartsContainer(
                key: updateKey,
                updateThemeCallback: (theme, chartTheme) {
                  UIManager.currentChartPalette = chartTheme;
                  UIManager.applicationCurrentTheme = theme;
                  setState(() {
                    updateKey = UniqueKey();
                  });
                }),
          ),
        ),
      ],
    );
  }
}
