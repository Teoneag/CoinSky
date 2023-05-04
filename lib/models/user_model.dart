import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final List<String> favouriteCoins; // symbols of the coins

  const User({
    required this.favouriteCoins,
    required this.email,
    required this.uid,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot['username'],
      uid: snapshot['uid'],
      favouriteCoins: [],
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'favouriteCoins': favouriteCoins,
      };
}
