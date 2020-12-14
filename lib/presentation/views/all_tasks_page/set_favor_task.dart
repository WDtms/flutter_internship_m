import 'package:flutter/material.dart';

class SetFavorTask extends StatefulWidget {

  final Function(bool isFavor) setFavor;

  SetFavorTask({this.setFavor});

  @override
  _SetFavorTaskState createState() => _SetFavorTaskState();
}

class _SetFavorTaskState extends State<SetFavorTask> {

  bool favor;

  @override
  void initState() {
    favor = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Создать задачу',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.values[4],
                color: Color(0xff424242),
              ),
            ),
            Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    favor = !favor;
                  });
                  widget.setFavor(favor);
                },
                child: Builder(
                  builder: (_) {
                    if (favor){
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.star,
                          color: Colors.orangeAccent,
                          size: 28,
                        ),
                      );
                    }
                    return Icon(
                      Icons.star_border,
                      color: Colors.black26,
                      size: 28,
                    );
                  },
                ),
              ),
            )
          ]
      ),
    );
  }
}
