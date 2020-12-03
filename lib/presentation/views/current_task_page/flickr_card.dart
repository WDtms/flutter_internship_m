import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/presentation/pages/flickr_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyFlickrCard extends StatelessWidget {

  final Map<Color, Color> theme;
  final String branchID;
  final String taskID;
  final Task task;
  final Function(String path) addImage;

  MyFlickrCard({this.theme, this.branchID, this.taskID, this.task, this.addImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 5),
          )
        ]
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (String image in task.imagesPath)
            _displayImages(context, image),
          _displayAddButton(context),
        ],
      ),
    );
  }

  _displayImages(BuildContext context, String filePath){
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context1){
            return SimpleDialog(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Установить эту картинку как заглавную?",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SimpleDialogOption(
                        child: Text(
                          'УСТАНОВИТЬ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        onPressed: () {
                          context.bloc<CurrentTaskCubit>().editTask(task.copyWith(selectedImage: filePath));
                          Navigator.of(context).pop();
                        },
                      ),
                      SimpleDialogOption(
                        child: Text(
                          'ОТМЕНА',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        );
      },
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context1){
              return SimpleDialog(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Удалить эту картинку?",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff424242),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SimpleDialogOption(
                          child: Text(
                            'УДАЛИТЬ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              color: Color(0xff424242),
                            ),
                          ),
                          onPressed: () {
                            List<String> allImages = task.imagesPath;
                            allImages.remove(filePath);
                            File(filePath).delete();
                            if (task.selectedImage == filePath)
                              context.bloc<CurrentTaskCubit>().editTask(task.copyWith(
                                imagesPath: allImages,
                                selectedImage: "",
                              ));
                            else
                              context.bloc<CurrentTaskCubit>().editTask(task.copyWith(
                                imagesPath: allImages,
                              ));
                            Navigator.of(context).pop();
                          },
                        ),
                        SimpleDialogOption(
                          child: Text(
                            'ОТМЕНА',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              color: Color(0xff424242),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
        );
      },
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Image.file(
          File(filePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _displayAddButton(BuildContext context){
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context1) => FlickrPage(
          theme: theme,
          addImage: addImage,
        )));
      },
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Color(0xff01A39D),
        ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Center(
          child: Icon(
            Icons.attachment,
            size: 36,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
