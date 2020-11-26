import 'package:flutter/material.dart';

class MyFlickrCard extends StatelessWidget {

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
          _displayAddButton(),
        ],
      ),
    );
  }

  _displayAddButton(){
    return InkWell(
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
