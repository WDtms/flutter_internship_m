import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/presentation/constants/my_themes_colors.dart';



class BottomDialog extends StatefulWidget{

  final Function(Map<Color, Color>) setBranchTheme;

  BottomDialog({this.setBranchTheme});

  @override
  _BottomDialogState createState() => _BottomDialogState();
}

class _BottomDialogState extends State<BottomDialog> {

  int _selectedRadio;

  @override
  void initState() {
    super.initState();
  }

  void setSelectedRadio(int value){
    setState(() {
      _selectedRadio = value;
    });
    widget.setBranchTheme(themes[value]);
  }

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
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(8),
            itemCount: themes.length,
            itemBuilder: (_, index) {
              return  Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: themes[index].keys.toList().elementAt(0),
                  ),
                  child: Radio(
                    value: index,
                    activeColor: Colors.indigo,
                    groupValue: _selectedRadio,
                    onChanged: (value) {
                      setSelectedRadio(value);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
