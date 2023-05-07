import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatC(double d) {
  return NumberFormat.compact().format(d);
}

String formatP(double d) {
  String s = NumberFormat.compact().format(d);
  return s.length > 6 ? s.substring(0, 7) : s;
}

String formatS(double d) {
  String s = '${d}00000'.substring(0, 5);
  if (s[s.length - 1] == '.') return s.substring(0, 4);
  return s;
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
