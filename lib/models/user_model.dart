import 'package:cloud_firestore/cloud_firestore.dart';

const uidS = 'uid';
const usrenameS = 'username';
const emailS = 'email';
const favouriteCoinsS = 'favouriteCoins';

class User {
  final String uid;
  final String username;
  final String email;
  final List favCoinsSym; // symbols of the coins
  const User({
    required this.uid,
    required this.username,
    required this.email,
    required this.favCoinsSym,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      uid: snapshot[uidS],
      username: snapshot[usrenameS],
      email: snapshot[emailS],
      favCoinsSym: snapshot[favouriteCoinsS],
    );
  }

  Map<String, dynamic> toJson() => {
        uidS: uid,
        usrenameS: username,
        emailS: email,
        favouriteCoinsS: favCoinsSym,
      };
}
