import 'package:cloud_firestore/cloud_firestore.dart';

const _uidS = 'uid';
const _usrenameS = 'username';
const _emailS = 'email';
const _favouriteCoinsS = 'favouriteCoins';

class User {
  final String uid;
  final String username;
  final String email;
  final List<String> favouriteCoins; // symbols of the coins

  const User({
    required this.uid,
    required this.username,
    required this.email,
    required this.favouriteCoins,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      uid: snapshot[_uidS],
      username: snapshot[_usrenameS],
      email: snapshot[_emailS],
      favouriteCoins:
          (snapshot[_favouriteCoinsS] as List<dynamic>).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() => {
        _uidS: uid,
        _usrenameS: username,
        _emailS: email,
        _favouriteCoinsS: favouriteCoins,
      };
}
