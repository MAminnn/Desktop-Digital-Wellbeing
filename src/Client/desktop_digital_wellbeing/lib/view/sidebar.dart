import 'package:desktop_digital_wellbeing/view/theme_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  createState() => _SideBar();
}

class _SideBar extends State<SideBar> {
  final SidebarXTheme extendedSidebarTheme = SidebarXTheme(
    margin: const EdgeInsets.all(2),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    decoration: BoxDecoration(
        color: ThemeManager.applicationDarkTheme.colorScheme.surface),
    width: 230,
    itemPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
    selectedItemPadding:
        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
    itemMargin: const EdgeInsets.symmetric(horizontal: 5),
    selectedItemMargin: const EdgeInsets.only(left: 14),
    itemTextPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    selectedItemTextPadding:
        const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
    textStyle: TextStyle(
        color: ThemeManager.applicationDarkTheme.colorScheme.secondary),
    selectedTextStyle:
        TextStyle(color: ThemeManager.applicationDarkTheme.colorScheme.surface),
    itemDecoration: BoxDecoration(
        color: Colors.transparent, borderRadius: BorderRadius.circular(15)),
    selectedItemDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: LinearGradient(
        colors: [
          ThemeManager.applicationDarkTheme.colorScheme.primary,
          ThemeManager.applicationDarkTheme.colorScheme.primary,
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: ThemeManager.applicationDarkTheme.colorScheme.primary,
          blurRadius: 8,
        )
      ],
    ),
    iconTheme: IconThemeData(
      color: ThemeManager.applicationDarkTheme.colorScheme.secondary,
      size: 20,
    ),
    selectedIconTheme: IconThemeData(
      color: ThemeManager.applicationDarkTheme.colorScheme.surface,
      size: 20,
    ),
  );
  final SidebarXTheme defaultSidebarTheme = SidebarXTheme(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ThemeManager.applicationDarkTheme.colorScheme.surface),
    itemPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
    selectedItemPadding:
        const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
    itemMargin: const EdgeInsets.symmetric(horizontal: 8),
    selectedItemMargin: const EdgeInsets.symmetric(horizontal: 8),
    itemTextPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
    selectedItemTextPadding:
        const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
    textStyle: TextStyle(
        color: ThemeManager.applicationDarkTheme.colorScheme.secondary),
    selectedTextStyle:
        TextStyle(color: ThemeManager.applicationDarkTheme.colorScheme.surface),
    itemDecoration: BoxDecoration(
        color: Colors.transparent, borderRadius: BorderRadius.circular(15)),
    selectedItemDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: LinearGradient(
        colors: [
          ThemeManager.applicationDarkTheme.colorScheme.primary,
          ThemeManager.applicationDarkTheme.colorScheme.primary,
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: ThemeManager.applicationDarkTheme.colorScheme.primary,
          blurRadius: 8,
        )
      ],
    ),
    iconTheme: IconThemeData(
      color: ThemeManager.applicationDarkTheme.colorScheme.secondary,
      size: 20,
    ),
    selectedIconTheme: IconThemeData(
      color: ThemeManager.applicationDarkTheme.colorScheme.surface,
      size: 20,
    ),
  );

  @override
  Widget build(BuildContext context) => SidebarX(
        controller: SidebarXController(selectedIndex: 0, extended: true),
        theme: defaultSidebarTheme,
        extendedTheme: extendedSidebarTheme,
        footerDivider: Divider(
            // thickness: 2,
            // color: ThemeManager.applicationDarkTheme.colorScheme.background

            indent: 8,
            endIndent: 8,
            color: ThemeManager.applicationDarkTheme.colorScheme.secondary),
        // headerBuilder: (context, extended) {
        //   return SizedBox(
        //     height: 100,
        //     child: Padding(
        //       padding: const EdgeInsets.all(16.0),
        //       child: Image.asset('assets/images/avatar.png'),
        //     ),
        //   );
        // },
        items: [
          SidebarXItem(
            icon: Icons.home,
            label: 'Home',
            onTap: () {
              debugPrint('Home');
            },
          ),
          const SidebarXItem(
            icon: Icons.search,
            label: 'Search',
          ),
          const SidebarXItem(
            icon: Icons.people,
            label: 'People',
          ),
          const SidebarXItem(
            icon: Icons.favorite,
            label: 'Favorites',
          ),
        ],
      );
}
