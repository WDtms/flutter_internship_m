import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/branch.dart';
import 'package:flutter_internship_v2/styles/my_themes_colors.dart';
import 'package:uuid/uuid.dart';

class CreateBranchForm extends StatefulWidget {

  final Function(Branch branch) createBranch;

  CreateBranchForm({this.createBranch});

  @override
  _CreateBranchFormState createState() => _CreateBranchFormState();
}

class _CreateBranchFormState extends State<CreateBranchForm> {

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SimpleDialog(
        contentPadding: EdgeInsets.all(12),
        children: <Widget>[
          Text(
            'Создать список',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
          TextFormField(
            onSaved: (String value) {
              widget.createBranch(
                Branch(
                  id: Uuid().v4(),
                  title: value,
                  theme: themes[0],
                  taskList: [],
                )
              );
            },
            validator: (value) {
              if(value.length > 10){
                return 'Превышена допустимая длина названия ветки задач';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Введите название списка",
              border: InputBorder.none,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SimpleDialogOption(
                child: Text(
                  'Отмена',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SimpleDialogOption(
                child: Text(
                  'Выбрать',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                ),
                onPressed: () {
                  if (_key.currentState.validate()){
                    _key.currentState.save();
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
}
