import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/cubit/theme/theme_cubit.dart';
import 'package:flutter_internship_v2/models/theme_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RadioButtonThemes extends StatefulWidget {

  @override
  _RadioButtonThemesState createState() => _RadioButtonThemesState();
}

class _RadioButtonThemesState extends State<RadioButtonThemes> {

  int selectedRadio;
  final themes = ThemeList().getAllThemes();

  @override
  void initState() {
    super.initState();
  }

  setSelectedRadio(int value){
    setState(() {
      selectedRadio = value;
    });
    context.bloc<ThemeCubit>().changeTheme(value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
