import 'coin_model.dart';

class Position {
  final String uid;
  final Coin coin1;
  final Coin coin2;
  final double leverage;
  final DateTime dataOpened;
  final double priceOpen;
  final DateTime dataClosed;
  final double priceClosed;
  final double fees;

  const Position({
    required this.uid,
    required this.coin1,
    required this.coin2,
    required this.leverage,
    required this.dataOpened,
    required this.priceOpen,
    required this.dataClosed,
    required this.priceClosed,
    required this.fees,
  });
}


// TODO: make storage_methods or smth for the position and the user models