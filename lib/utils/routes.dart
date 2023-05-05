import 'package:flutter/material.dart';
import '/screens/loading_screen.dart';
import '/screens/login_screen.dart';
import '/screens/register_screen.dart';
import '/screens/help_screen.dart';
import '/screens/home/home_screen.dart';
import '/screens/notification_screen.dart';
import '/screens/profile_screen.dart';
import '/screens/settings_screen.dart';
import '/screens/about_us_screen.dart';
import '/screens/home/coin_screen.dart';

class Routes {
  static const String loading = '/loading';
  static const String login = '/login';
  static const String register = '/register';
  // static const String verifyEmail = '/verify_email';
  static const String home = '/home';
  static const String help = '/help';
  static const String notifications = '/notifications';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String aboutUs = '/about_us';
  static const String coin = '/coin';
}

final Map<String, WidgetBuilder> routes = {
  Routes.login: (context) => const LoginScreen(),
  Routes.register: (context) => const RegisterScreen(),
  Routes.home: (context) => const MyHomeScreen(),
  Routes.help: (context) => const HelpScreen(),
  Routes.notifications: (context) => const NotificationScreen(),
  Routes.profile: (context) => const ProfileScreen(),
  Routes.settings: (context) => const SettingsScreen(),
  Routes.aboutUs: (context) => const AboutUsScreen(),
  // Routes.coin: (context) => CoinScreen(coin: coin,),
  Routes.loading: (context) => const LoadingScreen(),
};
