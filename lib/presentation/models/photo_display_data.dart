import 'package:flutter_internship_v2/data/models/image.dart';

class PhotoDataToDisplay{

  final List<Photo> photos;
  final String errorMessage;
  final String statusNotOkMessage;
  final int totalPages;
  int currentPage;

  PhotoDataToDisplay({this.photos, this.errorMessage, this.statusNotOkMessage, this.totalPages, this.currentPage});

}