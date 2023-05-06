class Coin {
  String? name;
  String symbol;
  String imageUrl;
  double marketCap;
  double marketCap24h;
  double price;
  double priceChange24h;

  Coin({
    this.name,
    required this.symbol,
    this.imageUrl =
        'https://static-00.iconduck.com/assets.00/generic-cryptocurrency-icon-512x512-rl54g8zo.png',
    this.marketCap = 0,
    this.marketCap24h = 0,
    this.price = 0,
    this.priceChange24h = 0,
  });

  factory Coin.fromJson1(Map<String, dynamic> json) {
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
        symbol: rawUSD['FROMSYMBOL'],
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
  factory Coin.fromJson2(Map<String, dynamic> json) {
    try {
      final rawUSD = json['USD'];
      return Coin(
        symbol: rawUSD['FROMSYMBOL'],
        imageUrl: 'https://www.cryptocompare.com${rawUSD['IMAGEURL']}',
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

Coin usd = Coin(
    name: 'USD',
    symbol: 'USD',
    imageUrl:
        'https://www.pngall.com/wp-content/uploads/12/USD-PNG-Images.png');
