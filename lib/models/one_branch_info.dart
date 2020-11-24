import 'package:flutter/material.dart';

class OneBranchInfo{

  final String id;
  final String title;
  final int countCompletedTasks;
  final int countUnCompletedTasks;
  final Color completedColor;
  final Color backGroundColor;
  final double progress;

  OneBranchInfo({
    this.id,
    this.title,
    this.countCompletedTasks,
    this.countUnCompletedTasks,
    this.completedColor,
    this.backGroundColor,
    this.progress,
  });

}