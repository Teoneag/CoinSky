import 'package:coin_sky_0/screens/home/coin_screen.dart';
import 'package:flutter/material.dart';
import '/utils/utils.dart';
import '/models/coin_model.dart';
import '../cryptocompare_api/cryptocompare_api_service.dart';

class CoinsList extends StatefulWidget {
  final CoinsListType type;
  const CoinsList({super.key, required this.type});

  @override
  State<CoinsList> createState() => _CoinsListState();
}

class _CoinsListState extends State<CoinsList> {
  final List<Coin> _coins = [];
  int _page = 0;
  bool _isLoading = false;
  bool _done = false;

  @override
  void initState() {
    _fetch();
    super.initState();
  }

  void _fetch() async {
    if (_isLoading) return;
    _isLoading = true;
    final newItems = await APIService.getCoins(_page, 14, widget.type);
    if (newItems == null) {
      if (mounted) {
        setState(() {
          _done = true;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _page++;
          _coins.addAll(newItems);
        });
      }
    }
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Row(
            children: [
              SizedBox(
                  width: 170,
                  child: Row(
                    children: [
                      Text('Rank',
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(width: 40),
                      Text('Symbol',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  )),
              Text('MktCap/24hV',
                  style: Theme.of(context).textTheme.bodyMedium),
              const Spacer(),
              Text('Price / 24h',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          pinned: true,
          toolbarHeight: 25,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index < _coins.length) {
                final coin = _coins[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoinScreen(coin: coin),
                        ));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
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
                              coin.name == null
                                  ? Text(coin.symbol)
                                  : Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            coin.name!,
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
                            color: coin.priceChange24h < 0
                                ? Colors.red
                                : Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                if (_done) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'End of list.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  _fetch();
                  return loadingCenterPadding();
                }
              }
            },
            childCount: _coins.length + 1,
          ),
        ),
      ],
    );
  }
}
