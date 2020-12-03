import 'dart:io';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/data/models/task.dart';
import 'package:flutter_internship_v2/presentation/bloc/current_task/current_task_cubit.dart';
import 'package:flutter_internship_v2/presentation/views/current_task_page/popup_appbar.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {

  final Color appBarColor;
  final Task task;
  final Function() updateTaskList;
  final Function() updateBranchesInfo;

  MySliverAppBar({this.appBarColor, this.task, this.updateTaskList, this.updateBranchesInfo});

  final double expandedHeight = 200;
  final double minHeight = 110;
  static const double fabSize = 60;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: fabSize/2),
          child: Container(
            color: appBarColor,
          ),
        ),
        _buildImage(shrinkOffset),
        _buildShadow(shrinkOffset),
        _buildTitle(shrinkOffset),
        _buildFab(shrinkOffset, context),
        _buildButtons(context, shrinkOffset),
      ],
    );
  }

  Widget _buildImage(double shrinkOffset) {
    if(task.selectedImage != "") {
      return Padding(
        padding: const EdgeInsets.only(bottom: fabSize / 2),
        child: Opacity(
          opacity: _calculateFabScale(shrinkOffset),
          child: Image.file(
            File(task.selectedImage),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildShadow(double shrinkOffset) {
    if (task.selectedImage != ""){
      return Padding(
        padding: const EdgeInsets.only(bottom: fabSize / 2),
        child: Opacity(
          opacity: _calculateFabScale(shrinkOffset),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 0,
                  blurRadius: 0,
                )
              ]
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildTitle(double shrinkOffset) {
    Map<double, double> calculatedAnimatedPaddings = _calculateAnimatedPadding(shrinkOffset);
    return Container(
      child: AnimatedPadding(
        padding: EdgeInsets.fromLTRB(
            calculatedAnimatedPaddings.keys.toList().first,
            0,
            calculatedAnimatedPaddings.values.toList().first,
            30
        ),
        duration: const Duration(milliseconds: 1),
        child: FlexibleSpaceBar.createSettings(
          minExtent: minExtent,
          maxExtent: maxExtent,
          currentExtent: max(minExtent, maxExtent - shrinkOffset - 30),
          child: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              task.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context, double shrinkOffset) {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      top: 30,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Container(
                decoration: BoxDecoration(
                  color: Color(0xff01A39D).withOpacity(task.selectedImage != ""
                      ? _calculateFabScale(shrinkOffset) : 0),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            PopupMenuCurrentTask(
              updateBranchesInfo: updateBranchesInfo,
              updateTaskList: updateTaskList,
              task: task,
              opacity: task.selectedImage != "" ? _calculateFabScale(shrinkOffset)
              : 0,
            ),
          ],
        ),
    );
  }

  Widget _buildFab(double shrinkOffset, BuildContext context){
    return Positioned(
      width: fabSize,
      height: fabSize,
      left: 16.0,
      bottom: 0.0,
      child: Transform.scale(
        scale: _calculateFabScale(shrinkOffset),
        child: FloatingActionButton(
          backgroundColor: Color(0xff01A39D),
          onPressed: () async {
            await context.bloc<CurrentTaskCubit>().editTask(task.copyWith(isDone: !task.isDone));
            updateTaskList();
          },
          child: Builder(
            builder: (context) {
              if (task.isDone)
                return Icon(Icons.close);
              return Icon(Icons.check);
            },
          ),
        ),
      ),
    );
  }

  Map<double, double> _calculateAnimatedPadding(double shrinkOffset){
    double scale = 0;
    if (shrinkOffset < expandedHeight - minHeight){
      scale = (expandedHeight - minHeight - shrinkOffset)/fabSize;
    }
    return {38+(46*scale): 38+(16*scale)};
  }

  double _calculateFabScale(double shrinkOffset){
    double scale;
    if (shrinkOffset < expandedHeight - minHeight - fabSize)
      scale = 1.0;
    else if (shrinkOffset < expandedHeight - minHeight){
      scale = (expandedHeight - minHeight - shrinkOffset)/fabSize;
    }
    else
      scale = 0.0;
    return scale;
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

}