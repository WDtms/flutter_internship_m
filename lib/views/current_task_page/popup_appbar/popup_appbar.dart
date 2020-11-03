
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/bloc/bloc_provider.dart';
import 'package:flutter_internship_v2/services/popup_current_task.dart';
import 'package:flutter_internship_v2/views/current_task_page/popup_appbar/form_dialog.dart';

class PopupMenu1 extends StatelessWidget {

  final int index;

  PopupMenu1({this.index});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).taskListBloc;
    return StreamBuilder(
      stream: bloc.tasks,
      builder: (context, snapshot) {
        return PopupMenuButton<String>(
          onSelected: (String choice) {
            if (choice == ConstantsOnPopUpCurrentTask.delete){
              Navigator.of(context).pop();
              bloc.deleteTask(snapshot.data[index]);
            }
            else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return FormDialogCurrentTask(index: index);
                  }
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return ConstantsOnPopUpCurrentTask.choices.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        );
      }
    );
  }
}
