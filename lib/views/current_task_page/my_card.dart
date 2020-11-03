import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/bloc/bloc_provider.dart';
import 'package:flutter_internship_v2/bloc/blocs/task_list.dart';

class MyCard1 extends StatefulWidget {

  final index;
  final backGroundColor;

  MyCard1({this.index, this.backGroundColor});

  @override
  _MyCardState1 createState() => _MyCardState1();
}

class _MyCardState1 extends State<MyCard1> {

  bool isCreating = false;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).taskListBloc;
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(8, 30, 8, 8),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0,2),
              )
            ]
        ),
        child: StreamBuilder(
          stream: bloc.tasks,
          builder: (context, snapshot) {
            if (!snapshot.hasData){
              return CircularProgressIndicator();
            }

            if (snapshot.data.isEmpty){
              return Container();
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (int i = 0; i<snapshot.data[widget.index].innerTasks.length; i++)
                  displayTask(bloc, snapshot, widget.index, i),
                decideWhatToDisplay(bloc, widget.index),
              ],
            );
          }
        ),
      ),
    );
  }

  displayTask(TaskListBloc bloc, AsyncSnapshot snapshot, int index, int innerIndex){
    if (snapshot.data.isEmpty){
      return Container(
        color: widget.backGroundColor,
      );
    }

    return  Padding(
      padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
      child: Container(
        child: Row(
          children: [
            Checkbox(
              value: snapshot.data[index].innerTasks[innerIndex].isDone,
              activeColor: Colors.black,
              onChanged: (bool value) {
                bloc.toggleInnerTaskComplete(snapshot.data[index], index, innerIndex);
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                    snapshot.data[index].innerTasks[innerIndex].title,
                    style: TextStyle(
                      fontSize: 14,
                    )),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                bloc.deleteInnerTask(snapshot.data[index], index, innerIndex);
              },
            )
          ],
        ),
      ),
    );
  }

  decideWhatToDisplay(TaskListBloc bloc, int index){
    if (isCreating){
      return Column(
        children: <Widget>[
          displayTextField(bloc, index),
          displayAddTask()
        ],
      );
    }
    else {
      return displayAddTask();
    }
  }

  displayTextField(TaskListBloc bloc, int index){
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: TextField(
        controller: _controller,
        onEditingComplete: () {
          bloc.createInnerTask(index, _controller.text);
          setState(() {
            _controller.text = "";
            isCreating = false;
          });
        },
      ),
    );
  }

  displayAddTask(){
    return InkWell(
        onTap: () {
          setState(() {
            isCreating = true;
          });
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
              child: Icon(
                Icons.add_sharp,
                color: Color(0xff1A9FFF),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                  'Добавить задачу',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff1A9FFF),
                  )
              ),
            ),
          ],
        )
    );
  }
}
