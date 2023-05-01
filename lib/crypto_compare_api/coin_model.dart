class Coin {
  String name;
  String symbol;
  String imageUrl;
  double marketCap;
  double marketCap24h;
  double price;
  double priceChange24h;

  Coin({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.marketCap,
    required this.marketCap24h,
    required this.price,
    required this.priceChange24h,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    final coinInfo = json['CoinInfo'];
    final rawUSD = json['RAW']['USD'];
    return Coin(
      name: coinInfo['FullName'],
      symbol: coinInfo['Name'],
      imageUrl: 'https://www.cryptocompare.com${coinInfo['ImageUrl']}',
      marketCap: rawUSD['MKTCAP'].toDouble(),
      marketCap24h: rawUSD['TOTALVOLUME24H'].toDouble(),
      price: rawUSD['PRICE'].toDouble(),
      priceChange24h: rawUSD['CHANGEPCT24HOUR'].toDouble(),
    );
  }
}
