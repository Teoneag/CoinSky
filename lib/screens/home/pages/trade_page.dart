import 'package:flutter/material.dart';

import '/crypto_compare_api/coin_model.dart';
import '/crypto_compare_api/crypto_compare_api_service.dart';

class TradePage extends StatefulWidget {
  const TradePage({super.key});

  @override
  State<TradePage> createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  List<Coin> _coins = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCoins();
  }

  void _getCoins() async {
    setState(() {
      _isLoading = true;
    });
    _coins = await APIService.getTopCoins();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: _coins.length,
            itemBuilder: (context, index) {
              final coin = _coins[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 190,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${index + 1}.'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(coin.imageUrl)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(coin.name),
                              Text(coin.symbol.toUpperCase()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text('\$${coin.marketCap.toStringAsFixed(2)}'),
                      Text('\$${coin.marketCap24h.toStringAsFixed(2)}'),
                    ],
                  ),
                  Column(
                    children: [
                      Text('\$${coin.price.toStringAsFixed(2)}'),
                      Text('${coin.priceChange24h.toStringAsFixed(2)}%'),
                    ],
                  ),
                ],
              );
            },
          );
  }
}
