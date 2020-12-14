import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_internship_v2/data/constants/my_themes_colors.dart';
import 'package:flutter_internship_v2/presentation/views/all_tasks_page/selected_circle.dart';

class ThemeDialog extends StatefulWidget {

  final Map<Color, Color> theme;
  final Function(Map<Color, Color>) setBranchTheme;

  ThemeDialog({this.setBranchTheme, this.theme});

  @override
  _ThemeDialogState createState() => _ThemeDialogState();
}

class _ThemeDialogState extends State<ThemeDialog> {

  int selectedValue;

  @override
  void initState() {
    selectedValue = themes.indexOf(widget.theme);
    super.initState();
  }

  setSelectedTheme(int value) {
    setState(() {
      selectedValue = value;
      widget.setBranchTheme(themes[value]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'Выбор темы',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return themeButton(index);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget themeButton(int index) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: themes[index].keys.toList().first,
            ),
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: InkWell(
                onTap: () {
                  setSelectedTheme(index);
                  },
                  child: Builder(
                    builder: (context) {
                      if (selectedValue == index){
                        return SelectedCircle(
                          radius: 30/4,
                        );
                      }
                      return SelectedCircle(
                        radius: 0.0,
                      );
                    },
                  ),
              ),
            ),
          ),
        ),
    );
  }
}
