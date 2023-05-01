import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/utils/routes.dart';
import '/utils/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinSky0',
      theme: lightTheme1,
      darkTheme: darkTheme1,
      themeMode: context.watch<ThemeController>().getThemeMode(),
      routes: routes,
      // home: HomePage(),
    );
  }
}
