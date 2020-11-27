import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget {

  final Color appBarColor;
  final Function() setBoolToFalse;
  final Function(String tag) onSubmitted;

  SearchAppBar({this.appBarColor, this.onSubmitted, this.setBoolToFalse});

  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.appBarColor,
      automaticallyImplyLeading: false,
      title: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: TextField(
          onSubmitted: (String tag) {
            widget.onSubmitted(tag);
          },
          style: TextStyle(
            fontSize: 18
          ),
          controller: _controller,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _controller.text = "";
              },
            ),
            prefixIcon: IconButton(
              icon: Icon(
                Icons.arrow_back_sharp,
                size: 30,
              ),
              onPressed: () {
                widget.setBoolToFalse();
              },
            ),
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            hintText: "Начните поиск по картинкам"
          ),
        ),
      ),
    );
  }
}
