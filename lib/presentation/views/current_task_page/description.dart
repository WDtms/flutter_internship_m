import 'package:flutter/material.dart';

class Description extends StatefulWidget {

  final Function(String value) onSubmitDescription;
  final String description;

  Description({this.description, this.onSubmitDescription});

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {

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
          initialValue: widget.description,
          maxLines: null,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Заметки по задаче...",
            labelText: "Заметки по задаче...",
          ),
          onFieldSubmitted: (String value) {
            widget.onSubmitDescription(value);
          },
        ),
      ),
    );
  }
}
