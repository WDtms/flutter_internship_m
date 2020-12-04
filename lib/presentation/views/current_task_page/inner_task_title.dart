import 'package:flutter/material.dart';

class InnerTaskTitle extends StatefulWidget {

  final String title;
  final Function(String newValue) onInnerTaskEdit;

  InnerTaskTitle({this.title, this.onInnerTaskEdit});

  @override
  _InnerTaskTitleState createState() => _InnerTaskTitleState();
}

class _InnerTaskTitleState extends State<InnerTaskTitle> {

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          style: TextStyle(
            color: Color(0xff424242),
          ),
          textInputAction: TextInputAction.done,
          initialValue: widget.title,
          maxLines: null,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          onFieldSubmitted: (String value) {
            widget.onInnerTaskEdit(value);
          },
        ),
      ),
    );
  }
}
