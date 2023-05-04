import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreMethods {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<String> addToFavorites(String coinSymbol) async {
    String res = "Some error occured";
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
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
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'favouriteCoins': FieldValue.arrayRemove([coinSymbol])
      });
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  static Future<bool> isCoinFavorite(String coinSymbol) async {
    try {
      var snap = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      return snap.data()!['favouriteCoins'].contains(coinSymbol);
    } catch (e) {
      return false;
    }
  }
}
