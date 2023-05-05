import 'dart:convert';
import 'package:coin_sky_0/firebase/auth_methods.dart';
import 'package:coin_sky_0/utils/utils.dart';
import 'package:http/http.dart' as http;
import '/models/coin_model.dart';

class APIService {
  // https://min-api.cryptocompare.com/data/v2/pair/mapping/exchange/fsym?exchangeFsym=BTC&limit=1000&exchange=binance
  static Future<List<Coin>?> getCoins(
      int page, int limit, CoinsListType type) async {
    try {
      switch (type) {
        case CoinsListType.liked:
          final currentUser = await AuthMethdods.getCurrentUser();
          final favoriteCoins = currentUser.favouriteCoins;
          String url =
              'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=${favoriteCoins.join(',')}&tsyms=USD';
          final response = await http
              .get(Uri.parse(url), headers: {'Accept': 'application/json'});
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            final List<dynamic> coinsData = data['RAW'].values.toList();
            if (coinsData.length < page * limit) {
              return null;
            }
            final coins =
                coinsData.map((json) => Coin.fromJson2(json)).toList();
            return coins;
          } else {
            throw Exception(
                'Failed to load data from API, statusCode was different from 200');
          }
        default:
          String url =
              'https://min-api.cryptocompare.com/data/top/mktcapfull?tsym=USD&limit=$limit&page=$page';
          final response = await http
              .get(Uri.parse(url), headers: {'Accept': 'application/json'});
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            final List<dynamic> coinsData = data['Data'];
            final coins =
                coinsData.map((json) => Coin.fromJson1(json)).toList();
            return coins;
          } else {
            throw Exception(
                'Failed to load data from API, statusCode was different from 200');
          }
      }
    } catch (e) {
      throw Exception(
          'Failed to load data from API, the following error was thrown: $e');
    }
  }
}
