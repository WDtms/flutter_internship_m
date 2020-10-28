import 'package:flutter/material.dart';

typedef ChangeThemeCallback(int value);

class BottomDialog extends StatefulWidget {

  final ChangeThemeCallback changeTheme;

  BottomDialog({this.changeTheme});

  @override
  _BottomDialogState createState() => _BottomDialogState();
}

class _BottomDialogState extends State<BottomDialog> {

  int selectedRadio;

  @override
  void initState() {
    super.initState();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      widget.changeTheme(selectedRadio);
    });
  }

  // Завтра переделаю.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: Text('Выбор темы'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff6200EE),
                  ),
                  child: Radio(
                    value: 0,
                    activeColor: Colors.indigo,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setSelectedRadio(value);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffbf360c),
                  ),
                  child: Radio(
                    value: 1,
                    activeColor: Colors.indigo,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setSelectedRadio(value);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff0d47a1),
                  ),
                  child: Radio(
                    value: 2,
                    activeColor: Colors.indigo,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setSelectedRadio(value);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff2e7d32),
                  ),
                  child: Radio(
                    value: 3,
                    activeColor: Colors.indigo,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setSelectedRadio(value);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff37474f),
                  ),
                  child: Radio(
                    value: 4,
                    activeColor: Colors.indigo,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setSelectedRadio(value);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff9e9d24),
                  ),
                  child: Radio(
                    value: 5,
                    activeColor: Colors.indigo,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setSelectedRadio(value);
                    },
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
