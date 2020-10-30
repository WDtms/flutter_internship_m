import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/models/task.dart';
import 'package:flutter_internship_v2/services/image.dart';
import 'package:flutter_internship_v2/styles/my_images.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaskList extends StatefulWidget{

  final Color iconsColor;
  final List<TaskModel> tasks;
  final bool isHidden;
  final List<TaskModel> tasksHidden;

  TaskList({this.isHidden, this.tasks, this.iconsColor, this.tasksHidden});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList>{

  final List<SvgPicture> images = ImageService.images;

  @override
  Widget build(BuildContext context) {
    if (widget.tasks.isEmpty) {
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
    } else {
      return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        itemCount: widget.tasks.length,
        itemBuilder: (_, index) {
          if (widget.isHidden == true){
            if (widget.tasksHidden.contains(widget.tasks[index])){
              return displayNothing();
            } else {
              return displayTask(index);
            }
          } else {
            return displayTask(index);
          }
        }
      );
    }
  }


   displayTask(int index){
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 2, 12, 2),
      child: Container(
        decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(5),
            color: Colors.white
        ),
        child: Row(
          children: [
            Checkbox(
              value: widget.tasks[index].isDone,
              activeColor: widget.iconsColor,
              onChanged: (bool value) {
                setState(() {
                  widget.tasks[index].isDone = value;
                });
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.tasks[index].title),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: widget.iconsColor,
              onPressed: () {
                setState(() {
                  widget.tasks.removeAt(index);
                });
              },
            )
          ],
        ),
      ),
    );
  }

  displayNothing(){
    return Container();
  }
}