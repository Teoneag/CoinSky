// // import 'dart:convert';

// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;

// // import '/coingecko_api/coin_model.dart';

// // class PortfolioPage extends StatefulWidget {
// //   const PortfolioPage({Key? key}) : super(key: key);

// //   @override
// //   _PortfolioPageState createState() => _PortfolioPageState();
// // }

// // class _PortfolioPageState extends State<PortfolioPage> {
// //   List<Coin> _coins = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _getCoins();
// //   }

// //   Future<void> _getCoins() async {
// //     try {
// //       final response = await http.get(Uri.parse(
// //           'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=false'));
// //       final Map<String, dynamic> jsonData = json.decode(response.body);
// //       final coinsData = jsonData['data'] as List<dynamic>;
// //       // final List<dynamic> jsonData = json.decode(response.body);
// //       final coins = coinsData.map((json) => Coin.fromJson(json)).toList();
// //       // final coins = jsonData.map((json) => Coin.fromJson(json)).toList();
// //       setState(() {
// //         _coins = coins;
// //       });
// //     } catch (error) {
// //       print('Error getting coins: $error');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Top 100 Coins'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: _coins.length,
// //         itemBuilder: (context, index) {
// //           final coin = _coins[index];
// //           return Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Container(
// //                 width: 210,
// //                 child: Row(
// //                   children: [
// //                     Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Text('${index + 1}.'),
// //                     ),
// //                     Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: CircleAvatar(
// //                           backgroundImage: NetworkImage(coin.imageUrl)),
// //                     ),
// //                     Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(coin.name),
// //                           Text(coin.symbol.toUpperCase()),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               Column(
// //                 children: [
// //                   Text(coin.marketCap.toStringAsFixed(2)),
// //                   Text('${coin.marketCapChange24h.toStringAsFixed(2)}%'),
// //                 ],
// //               ),
// //               Column(
// //                 children: [
// //                   Text(coin.price.toStringAsFixed(2)),
// //                   Text('${coin.priceChange24h.toStringAsFixed(2)}%'),
// //                 ],
// //               ),
// //             ],
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   Map<String, dynamic> jsonData = {};

//   @override
//   void initState() {
//     super.initState();
//     _getBtcPrice();
//   }

//   // all cryptos: nr, image, name, symbol, market cap, market cap change 24 hours, price, price change 24 hours, sparkline)
//   // if u tiped smth: /search
//   // if u didn't:
//   Future<void> _getBtcPrice() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd&include_market_cap=true&precision=2'));

//       setState(() {
//         jsonData = json.decode(response.body);
//       });
//     } catch (error) {
//       print('Error getting BTC price: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: jsonData.isNotEmpty
//           ? Text("\$${jsonData['bitcoin']['usd']}")
//           : const CircularProgressIndicator(),
//     );
//   }
// }
