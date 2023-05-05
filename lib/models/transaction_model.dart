import 'coin_model.dart';

const _uid = 'uid';
const _coinB = 'coinB';
const _coinS = 'coinS';
const _valueCoinB = 'valueCoinB';
const _valueCoinS = 'valueCoinS';
const _date = 'date';

class Trans {
  final String uid;
  final Coin coinB;
  final Coin coinS;
  final double valueCoinB;
  final double valueCoinS;
  final DateTime date;
  // final double fees;

  const Trans({
    required this.uid,
    required this.coinB,
    required this.coinS,
    required this.valueCoinB,
    required this.valueCoinS,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        _uid: uid,
        _coinB: coinB,
        _coinS: coinS,
        _valueCoinB: valueCoinB,
        _valueCoinS: valueCoinS,
        _date: date,
      };
}
