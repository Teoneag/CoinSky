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
    this.marketCap = 0,
    this.marketCap24h = 0,
    this.price = 0,
    this.priceChange24h = 0,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    try {
      final coinInfo = json['CoinInfo'];
      if (!json.containsKey('RAW')) {
        return Coin(
          name: coinInfo['FullName'],
          symbol: coinInfo['Name'],
          imageUrl: 'https://www.cryptocompare.com${coinInfo['ImageUrl']}',
        );
      }
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
    } catch (e) {
      throw Exception('We got this error trying to parse the data: $e');
    }
  }
}
