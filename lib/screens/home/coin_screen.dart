import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '/utils/utils.dart';
import '/models/coin_model.dart';
import '/widgets/favorite_button.dart';
import '/cryptocompare_api/cryptocompare_api_service.dart';
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
  List<FlSpot> _spots = [];
  bool _isLoading = false;

  @override
  void initState() {
    _coin2C = TextEditingController(text: '0.0');
    _coin1C = TextEditingController(text: '0.0');
    _fetchData();
    super.initState();
  }

  @override
  void dispose() {
    _coin1C.dispose();
    _coin2C.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    final spots = await APIService.getChartData(widget.coin.symbol);
    if (mounted) {
      setState(() {
        _spots = spots;
      });
    }
  }

  Future makeTransaction(
      String symbol1, String symbol2, String v1, String v2, double x) async {
    if (_isLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please wait for the last transaction to finish!')),
      );
      return;
    }
    final d1 = double.tryParse(v1) ?? 0.0;
    final d2 = double.tryParse(v2) ?? 0.0;
    if (d1 < S.threshold || d2 < S.threshold) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Value cannot be zero!')),
      );
    } else if (d2 > x + S.threshold) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Not enough $symbol2 to buy $symbol1: you need $d2 $symbol2 but you have $x $symbol2')),
      );
    } else {
      setState(() {
        _isLoading = true;
      });
      await FirestoreMethods.makeTransaction(
        coinB: symbol1,
        coinS: symbol2,
        valueCoinB: double.tryParse(v1) ?? 0.0,
        valueCoinS: double.tryParse(v2) ?? 0.0,
      );
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Transaction succesfull: you bought $v1 $symbol1 with $v2 $symbol2')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final coin = widget.coin;
    return Scaffold(
      appBar: AppBar(title: Text(coin.symbol)),
      body: SingleChildScrollView(
        child: StreamBuilder<List<double>>(
          stream: FirestoreMethods.getCoinAmountStream(coin.symbol, 'USD'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return loadingCenterPadding();
            final coinValues = snapshot.data!;
            final coin1 = coinValues[0];
            final coin2 = coinValues[1];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'You have: ${formatP(coin1)} ${coin.symbol} and ${formatP(coin2)} USD'),
                    ),
                    const Spacer(),
                    FavoriteButton(coinSymbol: coin.symbol),
                    const Spacer(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          makeTransaction(
                            coin.symbol,
                            'USD',
                            _coin1C.text,
                            _coin2C.text,
                            coin2,
                          );
                        },
                        child: _isLoading
                            ? loadingCenter()
                            : Column(
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
                              _coin2C.text =
                                  ((double.tryParse(x) ?? 0.0) * coin.price)
                                      .toStringAsFixed(2);
                            },
                            decoration:
                                InputDecoration(suffixText: coin.symbol),
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
                                  ((double.tryParse(x) ?? 0.0) / coin.price)
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
                            coin1,
                          );
                        },
                        child: _isLoading
                            ? loadingCenter()
                            : Column(
                                children: [
                                  Text('SELL ${coin.symbol}'),
                                  const Text('BUY USD'),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 550,
                    child: _spots.isEmpty
                        ? loadingCenter()
                        : LineChart(
                            LineChartData(
                              gridData: FlGridData(
                                drawVerticalLine: false,
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: _spots,
                                  dotData: FlDotData(
                                    show: false,
                                  ),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 50,
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 30,
                                    interval: 12000,
                                    getTitlesWidget: (value, meta) {
                                      final dateTime =
                                          DateTime.fromMillisecondsSinceEpoch(
                                              value.toInt() * 1000);
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${dateTime.hour}:00'),
                                      );
                                    },
                                  ),
                                ),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
