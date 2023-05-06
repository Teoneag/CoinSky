import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/utils/utils.dart';
import '/models/transaction_model.dart';
import '/firebase/auth_methods.dart';

class FirestoreMethods {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final _uid = _auth.currentUser!.uid;

  static Future<void> addToFavorites(String coinSymbol) async {
    try {
      await _firestore.collection(S.users).doc(_uid).update({
        'favouriteCoins': FieldValue.arrayUnion([coinSymbol])
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> removeFromFavorites(String coinSymbol) async {
    try {
      await _firestore.collection(S.users).doc(_uid).update({
        'favouriteCoins': FieldValue.arrayRemove([coinSymbol])
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> isCoinFavorite(String coinSymbol) async {
    final currentUser = await AuthMethdods.getCurrentUser();
    return currentUser.favouriteCoins.contains(coinSymbol);
  }

  static Future<void> makeTransaction({
    required String coinB,
    required String coinS,
    required double valueCoinB,
    required double valueCoinS,
  }) async {
    try {
      final Trans trans = Trans(
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
      await increaseCoinValue(coinSymbol: coinB, coinValue: valueCoinB);
      await increaseCoinValue(coinSymbol: coinS, coinValue: -valueCoinS);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> increaseCoinValue(
      {required String coinSymbol, required double coinValue}) async {
    try {
      final docRef = _firestore
          .collection(S.users)
          .doc(_uid)
          .collection(S.coins)
          .doc(coinSymbol);
      final snap = await docRef.get();
      final value = (snap.exists ? snap.get(S.value) : 0.0) + coinValue;
      await docRef.set({S.value: value});
    } catch (e) {
      print(e);
    }
  }

  static Stream<List<double>> getCoinAmountStream(String coin1, String coin2) {
    return _firestore
        .collection(S.users)
        .doc(_uid)
        .collection(S.coins)
        .snapshots()
        .map((snapshot) {
      final data = Map<String, double>.fromEntries(snapshot.docs.map((doc) {
        final value = doc.data()[S.value] as num? ?? 0.0;
        return MapEntry(doc.id, value.toDouble());
      }));
      return [data[coin1] ?? 0.0, data[coin2] ?? 0.0];
    });
  }
}
