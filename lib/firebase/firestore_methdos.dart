import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '/models/transaction_model.dart';
import '/models/coin_model.dart';
import '/utils/utils.dart';
import '/firebase/auth_methods.dart';

class FirestoreMethods {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final _uid = _auth.currentUser!.uid;

  static Future<String> addToFavorites(String coinSymbol) async {
    String res = "Some error occured";
    try {
      await _firestore.collection(S.users).doc(_uid).update({
        'favouriteCoins': FieldValue.arrayUnion([coinSymbol])
      });
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  static Future<String> removeFromFavorites(String coinSymbol) async {
    String res = "Some error occured";
    try {
      await _firestore.collection(S.users).doc(_uid).update({
        'favouriteCoins': FieldValue.arrayRemove([coinSymbol])
      });
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  static Future<bool> isCoinFavorite(String coinSymbol) async {
    final currentUser = await AuthMethdods.getCurrentUser();
    return currentUser.favouriteCoins.contains(coinSymbol);
  }

  static Future<String> makeTransaction({
    required Coin coinB,
    required Coin coinS,
    required double valueCoinB,
    required double valueCoinS,
  }) async {
    String res = "Some error occured";
    try {
      final Trans trans = Trans(
        uid: const Uuid().v1(),
        coinB: coinB,
        coinS: coinS,
        valueCoinB: valueCoinB,
        valueCoinS: valueCoinS,
        date: DateTime.now(),
      );
      await _firestore
          .collection(S.users)
          .doc(_uid)
          .collection(S.trans)
          .doc()
          .set(trans.toJson());
      res = success;
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  static Future<double?> getCoinAmount(String symbol) async {
    try {
      final snap = await _firestore.collection('users').doc(_uid).get();
      final coins = snap.data()!['myCoins'];
      return coins
          .map((coin) => coin[symbol])
          .firstWhere((value) => value != null, orElse: () => 0.0);
    } catch (e) {
      print(e);
      return 0;
    }
  }
}
