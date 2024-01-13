import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import '/utils/utils.dart';
import '/models/coin_model.dart';
import '/firebase/auth_methods.dart';
import '/firebase/firestore_methdos.dart';

const url_api = 'https://min-api.cryptocompare.com';

class APIService {
  static Future<double> getCoinprice(String symbol) async {
    final url = '$url_api/data/price?fsym=$symbol&tsyms=USD';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    final x = await data['USD'];
    return x.toDouble();
  }

  static Future<List<Coin>?> getCoins(
      int page, int limit, CoinsListType type) async {
    try {
      switch (type) {
        case CoinsListType.liked:
          final currentUser = await AuthMethdods.getCurrentUser();
          final favoriteCoins = currentUser.favCoinsSym;
          String url =
              '$url_api/data/pricemultifull?fsyms=${favoriteCoins.join(',')}&tsyms=USD';
          final response = await http
              .get(Uri.parse(url), headers: {'Accept': 'application/json'});
          final data = json.decode(response.body);
          final List<dynamic> coinsData = data['RAW'].values.toList();
          if (coinsData.length < page * limit) {
            return null;
          }
          final coins = coinsData.map((json) => Coin.fromJson2(json)).toList();
          return coins;
        case CoinsListType.owned:
          final ownedCoins = await FirestoreMethods.getOwnedCoins();
          String url =
              '$url_api/data/pricemultifull?fsyms=${ownedCoins.keys.join(',')}&tsyms=USD';
          final response = await http
              .get(Uri.parse(url), headers: {'Accept': 'application/json'});
          final data = json.decode(response.body);
          final List<dynamic> coinsData = data['RAW'].values.toList();
          if (coinsData.length < page * limit) {
            return null;
          }
          final coins = coinsData
              .map((json) => Coin.fromJson2(json,
                  amount: ownedCoins[json['USD']['FROMSYMBOL']]))
              .toList();
          return coins;
        default:
          String url =
              '$url_api/data/top/mktcapfull?tsym=USD&limit=$limit&page=$page';
          final response = await http
              .get(Uri.parse(url), headers: {'Accept': 'application/json'});
          final data = json.decode(response.body);
          final List<dynamic> coinsData = data['Data'];
          final coins = coinsData.map((json) => Coin.fromJson1(json)).toList();
          return coins;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<List<FlSpot>> getChartData(String coinSymbol) async {
    final response = await http.get(Uri.parse(
        '$url_api/data/v2/histominute?fsym=$coinSymbol&tsym=USD&limit=720'));
    final json = jsonDecode(response.body);
    final List data = json['Data']['Data'];
    final List<FlSpot> spots = [];
    for (int i = 0; i < data.length; i++) {
      final price = data[i]['close'].toDouble();
      final time = data[i]['time'].toDouble();
      spots.add(FlSpot(time, price));
    }
    return spots;
  }
}
