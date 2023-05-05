import 'package:flutter/material.dart';
import '/utils/utils.dart';
import '/widgets/coins_list.dart';

class TradePage extends StatelessWidget {
  const TradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoinsList(
      type: CoinsListType.all,
    );
  }
}
