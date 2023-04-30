import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '/utils/routes.dart';
import '/utils/theme.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: IconButton(
        icon: SvgPicture.asset(
          'assets/logo_CoinSky_1_2.svg',
        ),
        onPressed: () {},
        iconSize: 120,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.help);
          },
          icon: const Icon(Icons.help),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.notifications);
          },
          icon: const Icon(Icons.notifications),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.profile);
          },
          icon: const Icon(Icons.person),
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            Navigator.of(context).pushNamed(value);
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<String>(
              value: Routes.settings,
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ),
            PopupMenuItem(
              child: Consumer<ThemeController>(
                builder: (context, themeController, child) {
                  return SwitchListTile(
                    title: const Text('Theme'),
                    value: themeController.themeMode == ThemeModeType.dark,
                    onChanged: (value) {
                      themeController.setThemeMode(
                          value ? ThemeModeType.dark : ThemeModeType.light);
                    },
                  );
                },
              ),
            ),
            const PopupMenuItem<String>(
              value: Routes.aboutUs,
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text('About Us'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
