import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/presentation/views/all_tasks_page/importance_dialog.dart';

class FormDialog extends StatefulWidget {

  final Function(String value, DateTime dateToComplete, DateTime notificationTime, int importance) createTask;

  FormDialog({this.createTask});

  @override
  _FormDialogState createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog> {

  final _formKey = GlobalKey<FormState>();

  DateTime notificationTime;
  DateTime dateTimeToComplete;
  bool completeDateChosen = false;
  bool notificationTimeChosen = false;
  int importance = 1;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SimpleDialog(
        contentPadding: EdgeInsets.all(12),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Создать задачу',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.values[4],
                color: Color(0xff424242),
              ),
            ),
          ),
          TextFormField(
            key: const ValueKey('Task creation'),
            maxLength: 40,
            onSaved: (String value) {
              widget.createTask(value, dateTimeToComplete, notificationTime, importance);
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ImportanceDialog(
              importance: importance,
              changeImportance: (int value) {
                setState(() {
                  importance = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 50, 8),
            child: InkWell(
              onTap: () async {
                DateTime date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2022),
                );
                TimeOfDay time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (date != null && time != null) {
                  notificationTime = DateTime(
                      date.year, date.month, date.day, time.hour, time.minute);
                  setState(() {
                    notificationTimeChosen = true;
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffB5C9FD),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 4, 8, 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.notifications_active_outlined,
                        color: Colors.black54,
                        size: 26,
                      ),
                      Expanded(
                        child: Center(
                          child: Builder(
                              builder: (context) {
                                if (notificationTimeChosen){
                                  return Text(
                                    '${notificationTime.year}.'
                                        '${_decideHowToDisplay(notificationTime.month)}'
                                        '.${_decideHowToDisplay(notificationTime.day)}'
                                        ' в ${_decideHowToDisplay(notificationTime.hour)}'
                                        ':${_decideHowToDisplay(notificationTime.minute)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.black87
                                    ),
                                  );
                                }
                                return Text(
                                  'Напомнить',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                );
                              }
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 50, 8),
            child: InkWell(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2022),
                ).then((date) {
                  if (date != null) {
                    dateTimeToComplete =
                        DateTime(date.year, date.month, date.day, 23, 59, 59);
                    setState(() {
                      completeDateChosen = true;
                    });
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffB5C9FD),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 4, 8, 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.black54,
                        size: 26,
                      ),
                      Expanded(
                        child: Center(
                          child: Builder(
                            builder: (context) {
                              if (completeDateChosen){
                                return Text(
                                  '${dateTimeToComplete.year}.'
                                      '${_decideHowToDisplay(dateTimeToComplete.month)}.'
                                      '${_decideHowToDisplay(dateTimeToComplete.day)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black87
                                  ),
                                );
                              }
                              return Text(
                                'Дата выполнения',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              );
                            }
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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

  String _decideHowToDisplay(int val){
    if (val < 10)
      return "0$val";
    return "$val";
  }
}

