import 'package:flutter/material.dart';

class PopupItem extends StatelessWidget {

  final String title;
  final IconData icon;
  final bool logic;

  PopupItem({this.icon, this.logic, this.title});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context1) {
        if (logic != null && logic){
          return Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.check_circle,
                  size: 28,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Показать завершенные',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            ],
          );
        }
        return Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                icon,
                size: 28,
                color: Colors.black54,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ],
        );
        },
    );
  }
}
