import 'package:flutter/material.dart';

class FavorButton extends StatefulWidget {

  final bool isFavor;
  final Function() toggleFavor;

  FavorButton({this.isFavor, this.toggleFavor});

  @override
  _FavorButtonState createState() => _FavorButtonState();
}

class _FavorButtonState extends State<FavorButton> {

  bool _isFavor;

  @override
  void initState() {
    _isFavor = widget.isFavor;
    super.initState();
  }

  void setFavor() {
    setState(() {
      _isFavor = !_isFavor;
      widget.toggleFavor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setFavor();
      },
      child: Builder(
        builder: (_) {
          if (_isFavor)
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
