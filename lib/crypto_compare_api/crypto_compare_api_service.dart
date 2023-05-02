import 'dart:convert';
import 'package:http/http.dart' as http;

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

class APIService {
  // https://min-api.cryptocompare.com/data/v2/pair/mapping/exchange/fsym?exchangeFsym=BTC&limit=1000&exchange=binance
  static Future<List<Coin>> getCoins(int page, int limit) async {
    try {
      final response = await http.get(
          Uri.parse(
              'https://min-api.cryptocompare.com/data/top/mktcapfull?tsym=USD&limit=$limit&page=$page'),
          headers: {'Accept': 'application/json'});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // print('This is the data i got: $data');
        final List<dynamic> coinsData = data['Data'];
        final coins = coinsData.map((json) => Coin.fromJson(json)).toList();
        return coins;
      } else {
        throw Exception(
            'Failed to load data from API, statusCode was different from 200');
      }
    } catch (e) {
      throw Exception(
          'Failed to load data from API, the following error was thrown: $e');
    }
  }
}
