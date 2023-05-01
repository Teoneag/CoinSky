import 'package:flutter/material.dart';

import '/crypto_compare_api/crypto_compare_api_service.dart';

import '/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// TODO: Loading indicator, Sparkline, Refresh, tableHead, sort by table head item, at 743. it gets stuck, i should remove the bg colour of the icon, 9-10, 99-100 they are not alineated
// add log in
// at home add welcome xxx

class _HomePageState extends State<HomePage> {
  final List<Coin> _coins = [];
  int _page = 0;
  bool _isLoading = false;

  @override
  void initState() {
    _fetch();
    super.initState();
  }

  void _fetch() async {
    if (_isLoading) return;
    _isLoading = true;
    final newItems = await APIService.getCoins(_page, 14);
    setState(() {
      _page++;
      _coins.addAll(newItems);
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _coins.length + 1,
      itemBuilder: (context, index) {
        if (index < _coins.length) {
          final coin = _coins[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 170,
                  child: Row(
                    children: [
                      Text('${index + 1}.'),
                      const SizedBox(width: 10),
                      CircleAvatar(
                          backgroundImage: NetworkImage(coin.imageUrl)),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              coin.name,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              coin.symbol.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Text('\$${formatC(coin.marketCap)}'),
                    Text('\$${formatC(coin.marketCap24h)}'),
                  ],
                ),
                const Spacer(),
                Text(
                  '\$${formatS(coin.price)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  '${formatS(coin.priceChange24h)}%',
                  style: TextStyle(
                    color: coin.priceChange24h < 0 ? Colors.red : Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        } else {
          _fetch();
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
