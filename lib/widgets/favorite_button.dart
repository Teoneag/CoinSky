import 'package:flutter/material.dart';
import '/firebase/firestore_methdos.dart';

class FavoriteButton extends StatefulWidget {
  final String coinSymbol;

  const FavoriteButton({super.key, required this.coinSymbol});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isCoinFavorite();
  }

  void isCoinFavorite() async {
    bool result = await FirestoreMethods.isCoinFavorite(widget.coinSymbol);
    setState(() {
      isFavorite = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (isFavorite) {
          await FirestoreMethods.removeFromFavorites(widget.coinSymbol);
        } else {
          await FirestoreMethods.addToFavorites(widget.coinSymbol);
        }
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      child:
          isFavorite ? const Icon(Icons.star) : const Icon(Icons.star_border),
    );
  }
}
