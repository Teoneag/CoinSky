import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_sky_0/firebase/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/models/user_model.dart' as model;
import '/utils/utils.dart';

class FirestoreMethods {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final _uid = _auth.currentUser!.uid;

  static Future<String> getUsername() async {
    String res = "Some error occured";
    try {
      var snap = await _firestore.collection(S.users).doc(_uid).get();
      res = model.User.fromSnap(snap).username;
    } catch (e) {
      return '$e';
    }
    return res;
  }

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
}
