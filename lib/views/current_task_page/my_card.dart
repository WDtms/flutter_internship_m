import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/task.dart';

typedef ChangeIsDoneCallback(bool value, TaskModel task, int index);
typedef DeleteInnerTaskCallback(TaskModel task, int index);
typedef CreateInnerTaskCallback(TaskModel task, String value);

class MyCard extends StatefulWidget {

  final ChangeIsDoneCallback changeIsDone;
  final DeleteInnerTaskCallback deleteInnerTask;
  final CreateInnerTaskCallback createInnerTask;
  final TaskModel task;
  final Color appBarColor;

  MyCard({this.task, this.appBarColor ,this.changeIsDone, this.createInnerTask, this.deleteInnerTask});

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {

  bool isCreating = false;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 3,
                blurRadius: 2,
                offset: Offset(0,3)
              )
            ]
          ),
          height: 200.0,
          child: Builder(
            builder: (_) {

              if (widget.task.innerTasks.isEmpty){
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  itemCount: 1,
                  itemBuilder: (_, index){
                    if (isCreating){
                      return Column(
                        children: <Widget>[
                          displayTextField(),
                          displayAddTask()
                        ],
                      );
                    }
                    else {
                      return displayAddTask();
                    }
                    },
                );
              }
              else {
                return ListView.builder(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    itemCount: widget.task.innerTasks.length,
                    itemBuilder: (_, index) {

                      if (isCreating){
                        if (index == widget.task.innerTasks.length - 1){
                          return Column(
                            children: <Widget>[
                              displayTask(index),
                              displayTextField(),
                              displayAddTask()
                            ],
                          );
                        }
                        else {
                          return displayTask(index);
                        }
                      }
                      else {
                        if (index == widget.task.innerTasks.length - 1){
                          return Column(
                            children: <Widget>[
                              displayTask(index),
                              displayAddTask(),
                            ],
                          );
                        }
                        else {
                          return displayTask(index);
                        }
                      }
                    }
                    );
                }
              },
            ),
        )
      );
  }

  displayTask(int index){
    return  Padding(
      padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
      child: Container(
        child: Row(
          children: [
            Checkbox(
              value: widget.task.innerTasks[index].isDone,
              activeColor: widget.appBarColor,
              onChanged: (bool value) {
                setState(() {
                  widget.changeIsDone(value, widget.task, index);
                });
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  widget.task.innerTasks[index].title,
                  style: TextStyle(
                   fontSize: 14,
                  )),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  widget.deleteInnerTask(widget.task, index);
                });
              },
            )
          ],
        ),
      ),
    );
  }

  displayTextField(){
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: TextField(
        controller: _controller,
        onEditingComplete: () {
          setState(() {
            widget.createInnerTask(widget.task, _controller.text);
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
