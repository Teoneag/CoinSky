// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../coingecko_api/crypto_model.dart';

// class CryptoList extends StatefulWidget {
//   const CryptoList({super.key});

//   @override
//   _CryptoListState createState() => _CryptoListState();
// }

// class _CryptoListState extends State<CryptoList> {
//   List<Crypto> _cryptoList = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchCryptoList();
//   }

//   Future<void> _fetchCryptoList() async {
//     final response = await http
//         .get(Uri.parse('https://api.binance.com/api/v3/ticker/24hr?limit=20'));

//     if (response.statusCode == 200) {
//       final List<dynamic> responseData = jsonDecode(response.body);

//       setState(() {
//         _cryptoList = responseData.map((data) => Crypto.fromMap(data)).toList();
//       });
//     } else {
//       throw Exception('Failed to load crypto list');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Crypto List'),
//       ),
//       body: _cryptoList.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _cryptoList.length,
//               itemBuilder: (context, index) {
//                 final crypto = _cryptoList[index];

//                 return Card(
//                   child: ListTile(
//                     leading: Image.network(crypto.iconUrl),
//                     title: Text(crypto.name),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Price: \$${crypto.price}'),
//                         Text('Price Change 24h: ${crypto.priceChange24h}%'),
//                         Text('Market Cap: \$${crypto.totalMarketCap}'),
//                         Text('Market Cap 24h: \$${crypto.marketCap24h}'),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
