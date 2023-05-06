import 'package:flutter/material.dart';
import '/utils/utils.dart';
import '/models/coin_model.dart';
import '/firebase/firestore_methdos.dart';

class CoinScreen extends StatefulWidget {
  final Coin coin;
  const CoinScreen({super.key, required this.coin});

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  late final TextEditingController _coin1C;
  late final TextEditingController _coin2C;

  @override
  void initState() {
    _coin2C = TextEditingController(text: '0.0');
    _coin1C = TextEditingController(text: '0.0');
    super.initState();
  }

  @override
  void dispose() {
    _coin1C.dispose();
    _coin2C.dispose();
    super.dispose();
  }

  Future makeTransaction(
      String symbol1, String symbol2, String v1, String v2) async {
    final d1 = double.tryParse(v1) ?? 0.0;
    final d2 = double.tryParse(v2) ?? 0.0;
    if (d1.abs() < 0.00001 || d2.abs() < 0.00001) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Value cannot be zero!')),
      );
    } else {
      await FirestoreMethods.makeTransaction(
        coinB: symbol1,
        coinS: symbol2,
        valueCoinB: double.tryParse(v1) ?? 0.0,
        valueCoinS: double.tryParse(v2) ?? 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final coin = widget.coin;
    return Scaffold(
      appBar: AppBar(title: Text(coin.symbol)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<List<double>>(
            stream: FirestoreMethods.getCoinAmountStream(coin.symbol, 'USD'),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              final coinValues = snapshot.data!;
              final coin1 = coinValues[0];
              final coin2 = coinValues[1];
              return Text(
                  'You have: ${formatP(coin1)} ${coin.symbol} and ${formatP(coin2)} USD');
            },
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  makeTransaction(
                    coin.symbol,
                    'USD',
                    _coin1C.text,
                    _coin2C.text,
                  );
                },
                child: Column(
                  children: [
                    Text('BUY ${coin.symbol}'),
                    const Text('SELL USD'),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    controller: _coin1C,
                    keyboardType: TextInputType.number,
                    onChanged: (x) {
                      _coin2C.text = ((double.tryParse(x) ?? 0.0) * coin.price)
                          .toStringAsFixed(2);
                    },
                    decoration: InputDecoration(suffixText: coin.symbol),
                  ),
                ),
              ),
              const Text('≈'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    controller: _coin2C,
                    keyboardType: TextInputType.number,
                    onChanged: (x) {
                      _coin1C.text = ((double.tryParse(x) ?? 0.0) / coin.price)
                          .toStringAsFixed(4);
                    },
                    decoration: const InputDecoration(
                      suffixText: '\$',
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  makeTransaction(
                    'USD',
                    coin.symbol,
                    _coin2C.text,
                    _coin1C.text,
                  );
                },
                child: Column(
                  children: [
                    Text('SELL ${coin.symbol}'),
                    const Text('BUY USD'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
