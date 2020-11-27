import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/presentation/pages/flickr_page.dart';

class MyFlickrCard extends StatelessWidget {

  final Map<Color, Color> theme;

  MyFlickrCard({this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 5),
          )
        ]
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _displayAddButton(context),
        ],
      ),
    );
  }

  _displayAddButton(BuildContext context){
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => FlickrPage(theme: theme)));
      },
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Color(0xff01A39D),
        ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Center(
          child: Icon(
            Icons.add,
            size: 36,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
