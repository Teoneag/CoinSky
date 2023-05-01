// class Coin {
//   final String name;
//   final String symbol;
//   final String imageUrl;
//   final double marketCap;
//   final double marketCapChange24h;
//   final double price;
//   final double priceChange24h;

//   Coin({
//     required this.name,
//     required this.symbol,
//     required this.imageUrl,
//     required this.marketCap,
//     required this.marketCapChange24h,
//     required this.price,
//     required this.priceChange24h,
//   });

//   factory Coin.fromJson(Map<String, dynamic> json) {
//     return Coin(
//       name: json['name'],
//       symbol: json['symbol'],
//       imageUrl: json['image'],
//       marketCap: json['market_cap'].toDouble(),
//       marketCapChange24h: json['market_cap_change_percentage_24h'].toDouble(),
//       price: json['current_price'].toDouble(),
//       priceChange24h: json['price_change_percentage_24h'].toDouble(),
//     );
//   }
// }
