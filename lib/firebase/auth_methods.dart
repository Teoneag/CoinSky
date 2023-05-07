import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/models/user_model.dart' as model;
import '/utils/utils.dart';

class AuthMethdods {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _uid = _auth.currentUser!.uid;

  static Future<String> loginUser(email, password) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = success;
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  static Future<String> registerUser({
    required String email,
    required String password,
    required String username,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        model.User user = model.User(
          email: email,
          uid: cred.user!.uid,
          username: username,
          favouriteCoins: [
            'BTC',
            'ETH',
            'USDT',
            'BNB',
            'XRP',
            'ADA',
            'SOL',
            'DOGE'
          ],
        );
        await _firestore
            .collection(S.users)
            .doc(cred.user!.uid)
            .set(user.toJson());
        await _firestore
            .collection(S.users)
            .doc(cred.user!.uid)
            .collection(S.coins)
            .doc('USD')
            .set({S.value: 1000.0});
        res = success;
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<model.User> getCurrentUser() async {
    final snapshot = await _firestore.collection(S.users).doc(_uid).get();
    return model.User.fromSnap(snapshot);
  }

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
}
