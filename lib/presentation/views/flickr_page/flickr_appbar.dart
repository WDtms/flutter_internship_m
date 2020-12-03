import 'package:flutter/material.dart';

class FlickrAppBar extends StatefulWidget {

  final Color appBarColor;
  final Function(String searchText) searchPhotos;

  FlickrAppBar({this.appBarColor, this.searchPhotos});

  @override
  _FlickrAppBarState createState() => _FlickrAppBarState();
}

class _FlickrAppBarState extends State<FlickrAppBar> {

  bool _isSearching;
  TextEditingController _controller;

  @override
  void initState() {
    _isSearching = false;
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !_isSearching ?
      AppBar(
        title: Text('Flickr'),
        backgroundColor: widget.appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = true;
              });
            },
          ),
        ],
      ) : AppBar(
        backgroundColor: widget.appBarColor,
        automaticallyImplyLeading: false,
        titleSpacing: 8.0,
        title: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: TextField(
            onSubmitted: (String tag) {
              widget.searchPhotos(tag);
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
                    FocusScope.of(context).canRequestFocus = false;
                    setState(() {
                      _controller.text = "";
                      _isSearching = false;
                    });
                    Future.delayed(Duration(milliseconds: 100), () {
                      FocusScope.of(context).canRequestFocus = true;
                    });
                  },
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: "Начните поиск по картинкам"
            ),
          ),
        ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
