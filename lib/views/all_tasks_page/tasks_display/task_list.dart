import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/bloc/bloc_provider.dart';
import 'package:flutter_internship_v2/bloc/blocs/task_list.dart';
import 'package:flutter_internship_v2/models/inner_task.dart';
import 'package:flutter_internship_v2/pages/current_task.dart';
import 'package:flutter_internship_v2/styles/my_images.dart';
import 'package:flutter_svg/flutter_svg.dart';


class TaskList1 extends StatelessWidget {

  final backGroundColor;
  final appBarColor;

  TaskList1({this.appBarColor, this.backGroundColor});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).taskListBloc;
    return StreamBuilder(
      stream: bloc.tasks,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );

        if(snapshot.data.isEmpty){
          return displayImages();
        }

        return ListView.builder(
          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return displayTask(context, bloc, snapshot, index);
          },
        );
      },
    );
  }

  int countCompletedInnerTasks(AsyncSnapshot snapshot, int index){
    int count = 0;
    for (InnerTask task in snapshot.data[index].innerTasks){
      if (task.isDone){
        count++;
      }
    }
    return count;
  }

  Widget displayImages(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(home_image),
          Container(
            height: 3,
          ),
          SvgPicture.asset(home_text),
        ],
      ),
    );
  }

  Widget displayTask(BuildContext context, TaskListBloc bloc, AsyncSnapshot snapshot, int index) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) {
        bloc.deleteTask(snapshot.data[index]);
      },
      background: Container(
        margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
        padding: EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(8),
          color: Colors.redAccent,
        ),
        alignment: AlignmentDirectional.centerEnd,
        child: Icon(
            Icons.delete,
            color: Colors.white
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
        child: Container(
          decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(8),
              color: Colors.white
          ),
          child: Row(
            children: [
              Checkbox(
                value: snapshot.data[index].isDone,
                activeColor: appBarColor,
                onChanged: (bool value) {
                  bloc.toggleTaskComplete(snapshot.data[index], index);
                },
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CurrentTask1(index: index, appBarColor: appBarColor, backGroundColor: backGroundColor,)));
                  },
                  child: Builder(
                    builder: (BuildContext context) {

                      if (snapshot.data[index].innerTasks.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(snapshot.data[index].title),
                        );
                      }

                      else {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 4),
                                child: Text(snapshot.data[index].title),
                              ),
                              Text('${countCompletedInnerTasks(snapshot, index)} из ${snapshot.data[index].innerTasks.length}')
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}