import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatC(double d) {
  return NumberFormat.compact().format(d);
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
  // static const positions = 'positions';
  static const trans = 'trans';
}

enum CoinsListType { all, liked }
