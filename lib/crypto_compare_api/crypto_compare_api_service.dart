import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/coin_model.dart';

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
