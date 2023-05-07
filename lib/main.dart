import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/utils/routes.dart';
import '/utils/theme.dart';
import 'firebase_options.dart';
import 'screens/home/home_screen.dart';
import 'screens/login_screen.dart';
import '/screens/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeController(),
      child: MyApp(
        isDarkTheme: isDarkTheme,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isDarkTheme;
  const MyApp({super.key, required this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinSky',
      theme: lightTheme1,
      darkTheme: darkTheme1,
      themeMode: isDarkTheme ? ThemeMode.light : ThemeMode.dark,
      routes: routes,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasData) {
            return const MyHomeScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
