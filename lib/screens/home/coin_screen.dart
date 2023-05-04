import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '/widgets/favorite_button.dart';
import '/models/coin_model.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({super.key});

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  late final WebViewController controller;
  String url = 'https://www.tradingview.com/chart/?symbol=BTCUSD';

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (navigation) {
            if (navigation.url != url) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final Coin coin = args['coin'];
    return Scaffold(
      appBar: AppBar(
        title: Text(coin.symbol),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Buy'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Sell'),
              ),
              FavoriteButton(coinSymbol: coin.symbol),
            ],
          ),
          Expanded(
            child: WebViewWidget(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
