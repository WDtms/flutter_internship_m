import 'package:flutter/material.dart';

class TryAgainButton extends StatefulWidget {

  final Map<Color, Color> theme;
  final Function() fetchMorePhotos;

  TryAgainButton({this.theme, this.fetchMorePhotos});

  @override
  _TryAgainButtonState createState() => _TryAgainButtonState();
}

class _TryAgainButtonState extends State<TryAgainButton> {

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (isSearching){
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(widget.theme.keys.toList().first),
            ),
          );
        }
        return RaisedButton(
          child: Text(
            'Попробовать еще',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18
            ),
          ),
          onPressed: () async {
            setState(() {
              isSearching = true;
            });
            await widget.fetchMorePhotos();
            setState(() {
              isSearching = false;
            });
          },
          color: widget.theme.keys.toList().first,
        );
      },
    );
  }
}
