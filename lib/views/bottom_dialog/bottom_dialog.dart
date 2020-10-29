import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/views/bottom_dialog/choice_theme.dart';

typedef ChangeThemeCallback(int value);

class BottomDialog extends StatefulWidget {

  final ChangeThemeCallback changeTheme;

  BottomDialog({this.changeTheme});

  @override
  _BottomDialogState createState() => _BottomDialogState();
}

class _BottomDialogState extends State<BottomDialog> {

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
        RadioButtonThemes(changeTheme: widget.changeTheme)
      ],
    );
  }
}
