import 'package:flutter/material.dart';

class PopupItem extends StatelessWidget {

  final String title;
  final IconData icon;
  final bool hiddenLogic;
  final bool newestLogic;
  final bool importanceLogic;

  PopupItem({this.icon, this.title, this.hiddenLogic, this.newestLogic, this.importanceLogic});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context1) {
        if (hiddenLogic != null && hiddenLogic){
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
        } else if (newestLogic != null && newestLogic){
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
                'Сначала старые',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            ],
          );
        }
        else if (importanceLogic != null && importanceLogic){
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
                'Отключить важность',
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
