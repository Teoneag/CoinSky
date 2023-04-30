import 'package:flutter/material.dart';

import '/screens/home/pages/home_page.dart';
import '/screens/home/pages/portfolio_page.dart';
import '/screens/home/pages/trade_page.dart';
import '/screens/home/pages/earn_page.dart';
import '/screens/home/pages/learn_page.dart';

final List<Widget> pages = [
  const HomePage(),
  const PortfolioPage(),
  const TradePage(),
  const EarnPage(),
  const LearnPage(),
];
