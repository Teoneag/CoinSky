import 'package:coin_sky_0/utils/utils.dart';
import 'package:flutter/material.dart';
import '/widgets/coins_list.dart';

class TradePage extends StatelessWidget {
  const TradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoinsList(
      type: coinsListType.all,
    );
  }
}
