import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef CreateTaskCallback(String taskName);

class FloatingButton extends StatefulWidget {

  final CreateTaskCallback onTaskCreate;

  FloatingButton({this.onTaskCreate});

  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add_sharp),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Form(
                key: _formKey,
                child: SimpleDialog(
                  contentPadding: EdgeInsets.all(12),
                  children: <Widget>[
                    Text('Создать задачу'),
                    TextFormField(
                        onSaved: (String value) {
                          setState(() {
                            widget.onTaskCreate(value);
                          });
                        },
                        validator: (value){
                          if(value.length > 40){
                            return 'Превышена допустимая длина задачи';
                          }
                          return null;
                        }
                    ),
                    Row(
                      children: <Widget>[
                        SimpleDialogOption(
                          child: Text('Отмена'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SimpleDialogOption(
                          child: Text('Создать'),
                          onPressed: () {
                            if (_formKey.currentState.validate()){
                              _formKey.currentState.save();
                              Navigator.of(context).pop();
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              );
            }
        );
      },
      backgroundColor: Colors.teal,
    );
  }
}
