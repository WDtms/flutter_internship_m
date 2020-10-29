import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/services/themes.dart';

typedef ChangeThemeCallback(int value);

class RadioButtonThemes extends StatefulWidget {

  final ChangeThemeCallback changeTheme;

  RadioButtonThemes({this.changeTheme});

  @override
  _RadioButtonThemesState createState() => _RadioButtonThemesState();
}

class _RadioButtonThemesState extends State<RadioButtonThemes> {

  int selectedRadio;

  setSelectedRadio(int value){
    setState(() {
      selectedRadio = value;
      widget.changeTheme(selectedRadio);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(8),
        itemCount: ListOfThemes.themes.length,
        itemBuilder: (_, index) {
          return  Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ListOfThemes.themes[index].keys.toList().elementAt(0),
              ),
              child: Radio(
                value: index,
                activeColor: Colors.indigo,
                groupValue: selectedRadio,
                onChanged: (value) {
                  setSelectedRadio(value);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
