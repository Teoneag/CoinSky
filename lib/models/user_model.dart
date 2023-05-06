import 'package:cloud_firestore/cloud_firestore.dart';

const uidS = 'uid';
const usrenameS = 'username';
const emailS = 'email';
const favouriteCoinsS = 'favouriteCoins';
const myCoinsS = 'myCoins';

class User {
  final String uid;
  final String username;
  final String email;
  final List favouriteCoins; // symbols of the coins
  final List myCoins;
  const User({
    required this.uid,
    required this.username,
    required this.email,
    required this.favouriteCoins,
    required this.myCoins,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      uid: snapshot[uidS],
      username: snapshot[usrenameS],
      email: snapshot[emailS],
      favouriteCoins: snapshot[favouriteCoinsS],
      myCoins: snapshot[myCoinsS],
    );
  }

  Map<String, dynamic> toJson() => {
        uidS: uid,
        usrenameS: username,
        emailS: email,
        favouriteCoinsS: favouriteCoins,
        myCoinsS: myCoins,
      };
}
