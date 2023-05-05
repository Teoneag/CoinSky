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
  late final TextEditingController _usdC;
  late final TextEditingController _btcC;
  double coin1 = 0.0;
  double coin2 = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    _usdC = TextEditingController(text: '0');
    _btcC = TextEditingController(text: '0');
    getInitialValues();
    super.initState();
  }

  @override
  void dispose() {
    _usdC.dispose();
    _btcC.dispose();
    super.dispose();
  }

  void _updateUsdValue(String value) {
    double btc = double.tryParse(value) ?? 0.0;
    double usd = btc * widget.coin.price;
    _usdC.text = usd.toStringAsFixed(2);
  }

  void _updateBtcValue(String value) {
    double usd = double.tryParse(value) ?? 0;
    double btc = usd / widget.coin.price;
    _btcC.text = btc.toStringAsFixed(4);
  }

  Future<void> getInitialValues() async {
    coin1 = await FirestoreMethods.getCoinAmount(widget.coin.symbol) ?? 0.0;
    coin2 = await FirestoreMethods.getCoinAmount('USD') ?? 0.0;
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
                    : Text('$coin1 ${widget.coin.symbol} and $coin2 USD'),
              ],
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
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
                    controller: _btcC,
                    keyboardType: TextInputType.number,
                    onChanged: _updateUsdValue,
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
                    controller: _usdC,
                    keyboardType: TextInputType.number,
                    onChanged: _updateBtcValue,
                    decoration: const InputDecoration(
                      suffixText: '\$',
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
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
