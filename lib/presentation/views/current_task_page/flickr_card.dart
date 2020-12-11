import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/add_image_dialog.dart';

class MyFlickrCard extends StatelessWidget {

  final Map<Color, Color> theme;
  final String branchID;
  final String taskID;
  final Task task;

  MyFlickrCard({this.theme, this.branchID, this.taskID, this.task});

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
          for (int i = 0; i<task.imagesPath.length; i++)
            _displayImages(context, task.imagesPath[i], i),
          _displayAddButton(context),
        ],
      ),
    );
  }

  _displayImages(BuildContext context, String filePath, int index){
    return InkWell(
      key: ValueKey('$index'),
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
                          context.bloc<CurrentTaskCubit>().selectImage(filePath);
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
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Stack(
          children: [
            Image.file(
              File(filePath),
              height: 140,
              width: 140,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment(0.9, -0.9),
              child: InkWell(
                onTap: () {
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
                                    onPressed: () async {
                                      await context.bloc<CurrentTaskCubit>()
                                          .deleteImage(filePath);
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff01A39D),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _displayAddButton(BuildContext context){
    return InkWell(
      key: ValueKey('Добавить картинку'),
      onTap: () {
        _showImagePickerDialog(context);
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

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext zeroContext){
        return AddImageDialog(
          addImage: (String value) {
            context.bloc<CurrentTaskCubit>().addImage(value);
          },
          theme: theme,
        );
      }
    );
  }
}
