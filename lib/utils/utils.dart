import 'package:intl/intl.dart';

String formatC(double d) {
  return NumberFormat.compact().format(d);
}

String formatS(double d) {
  String s = '${d}00000'.substring(0, 5);
  if (s[s.length - 1] == '.') return s.substring(0, 4);
  return s;
}
