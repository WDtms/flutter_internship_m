import 'package:flutter/material.dart';

class FavorButton extends StatelessWidget {

  final bool isFavor;
  final Function() toggleFavor;

  FavorButton({this.isFavor, this.toggleFavor});

  void setFavor() {
    toggleFavor();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setFavor();
      },
      child: Builder(
        builder: (_) {
          if (isFavor)
            return Icon(
              Icons.star,
              color: Colors.orangeAccent,
            );
          return Icon(
            Icons.star_border,
            color: Colors.black26,
          );
        },
      ),
    );
  }
}
