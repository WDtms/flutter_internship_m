import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/presentation/views/all_tasks_page/complete_date_selector.dart';
import 'package:flutter_internship_v2/presentation/views/all_tasks_page/notification_selector.dart';
import 'package:flutter_internship_v2/presentation/views/all_tasks_page/importance_dialog.dart';
import 'package:flutter_internship_v2/presentation/views/all_tasks_page/favor_selector.dart';

class FormDialog extends StatefulWidget {

  final Function(String value, DateTime dateToComplete,
      DateTime notificationTime, int importance, bool favor) createTask;

  FormDialog({this.createTask});

  @override
  _FormDialogState createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog> {

  final _formKey = GlobalKey<FormState>();

  DateTime notificationTime;
  DateTime dateTimeToComplete;
  int importance;
  bool favor;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SimpleDialog(
        contentPadding: EdgeInsets.all(12),
        children: <Widget>[
          TaskFavorSelector(
            setFavor: (bool isFavor) {
              favor = isFavor;
            },
          ),
          TextFormField(
            key: const ValueKey('Task creation'),
            maxLength: 40,
            onSaved: (String value) {
              widget.createTask(value, dateTimeToComplete, notificationTime, importance, favor);
              },
            validator: (value){
              if(value.length > 40){
                return 'Превышена допустимая длина задачи';
              }
              return null;
              },
            decoration: InputDecoration(
              hintText: "Введите название задачи",
              border: InputBorder.none
            )
          ),
          ImportanceDialog(
            setImportance: (int value) {
              importance = value;
            },
          ),
          NotificationDateSelector(
            setNotification: (DateTime date) {
              notificationTime = date;
            },
          ),
          DateToCompleteSelector(
            setDateToComplete: (DateTime date) {
              dateTimeToComplete = date;
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SimpleDialogOption(
                  child: Text(
                    'ОТМЕНА',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                        color: Color(0xff424242),
                      fontSize: 16
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SimpleDialogOption(
                  child: Text(
                    'СОЗДАТЬ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff424242),
                        fontSize: 16
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()){
                      _formKey.currentState.save();
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

