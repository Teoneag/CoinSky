import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatN(double d) {
  if (d.abs() < 1e-4) return '0';
  String s = NumberFormat.compact().format(d);
  return s.length > 6 ? s.substring(0, 7) : s;
}

String formatP(double d) {
  if (d.abs() < 1e-5) return '0';
  NumberFormat formatter = NumberFormat.compact();
  formatter.maximumFractionDigits = 2;
  return formatter.format(d);
}

const success = 'success';

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

class S {
  static const users = 'users';
  static const trans = 'trans';
  static const value = 'value';
  static const coins = 'coins';
  static const themeMode = 'THEME_MODE';
  static const threshold = 0.00001;
}

enum CoinsListType { all, liked, owned }

Widget loadingPadding() {
  return const Padding(
    padding: EdgeInsets.all(8.0),
    child: CircularProgressIndicator(),
  );
}

Widget loadingCenter() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget loadingCenterPadding() {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: CircularProgressIndicator(),
    ),
  );
}
