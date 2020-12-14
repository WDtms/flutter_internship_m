import 'package:flutter/material.dart';

class DateToCompleteSelector extends StatefulWidget {

  final Function(DateTime dateToComplete) setDateToComplete;

  DateToCompleteSelector({this.setDateToComplete});

  @override
  _DateToCompleteSelectorState createState() => _DateToCompleteSelectorState();
}

class _DateToCompleteSelectorState extends State<DateToCompleteSelector> {

  bool completeDateChosen;
  DateTime dateTimeToComplete;

  @override
  void initState() {
    completeDateChosen = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              widget.setDateToComplete(dateTimeToComplete);
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
    );
  }

  String _decideHowToDisplay(int val){
    if (val < 10)
      return "0$val";
    return "$val";
  }
}
