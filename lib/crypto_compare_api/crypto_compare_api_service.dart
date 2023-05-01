import 'dart:convert';
import 'package:http/http.dart' as http;

import '/crypto_compare_api/coin_model.dart';

class APIService {
  static const String _baseUrl =
      'https://min-api.cryptocompare.com/data/top/mktcapfull?tsym=USD&limit=20';

  static Future<List<Coin>> getTopCoins() async {
    try {
      final response = await http
          .get(Uri.parse(_baseUrl), headers: {'Accept': 'application/json'});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> coinsData = data['Data'];
        final coins = coinsData.map((json) => Coin.fromJson(json)).toList();
        return coins;
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (e) {
      throw Exception('Failed to load data from API');
    }
  }
}
