import 'package:flutter/material.dart';
// import '/widgets/favorite_button.dart';
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
  double _coin1 = 0.0;
  double _coin2 = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    _coin2C = TextEditingController(text: '0.0');
    _coin1C = TextEditingController(text: '0.0');
    _fetchCoinValues();
    super.initState();
  }

  @override
  void dispose() {
    _coin1C.dispose();
    _coin2C.dispose();
    super.dispose();
  }

  Future<void> _fetchCoinValues() async {
    _coin1 = await FirestoreMethods.getCoinAmount(widget.coin.symbol) ?? 0.0;
    _coin2 = await FirestoreMethods.getCoinAmount('USD') ?? 0.0;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coin.symbol),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text('You have: '),
                _isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )
                    : Text('$_coin1 ${widget.coin.symbol} and $_coin2 USD'),
              ],
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await FirestoreMethods.makeTransaction(
                    coinB: widget.coin.symbol,
                    coinS: 'USD',
                    valueCoinB: double.tryParse(_coin1C.text) ?? 0.0,
                    valueCoinS: double.tryParse(_coin2C.text) ?? 0.0,
                  );
                },
                child: Column(
                  children: [
                    Text('BUY ${widget.coin.symbol}'),
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
                      _coin2C.text =
                          ((double.tryParse(x) ?? 0.0) * widget.coin.price)
                              .toStringAsFixed(2);
                    },
                    decoration: InputDecoration(
                      suffixText: widget.coin.symbol,
                    ),
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
                      _coin1C.text =
                          ((double.tryParse(x) ?? 0.0) / widget.coin.price)
                              .toStringAsFixed(4);
                    },
                    decoration: const InputDecoration(
                      suffixText: '\$',
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirestoreMethods.makeTransaction(
                    coinB: 'USD',
                    coinS: widget.coin.symbol,
                    valueCoinS: double.tryParse(_coin1C.text) ?? 0.0,
                    valueCoinB: double.tryParse(_coin2C.text) ?? 0.0,
                  );
                },
                child: Column(
                  children: [
                    Text('SELL ${widget.coin.symbol}'),
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
