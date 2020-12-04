import 'package:flutter_internship_v2/data/models/image.dart';

class PhotoDataToDisplay{

  //Поле списка url всех картинок
  final List<Photo> photos;
  //
  //Поле ошибки при запросе
  final String errorMessage;
  //
  //Поле ошибки фликра
  final String statusNotOkMessage;
  //
  //Поле количества всех страниц
  final int totalPages;
  //
  //Поле текущей страницы. Настраивается в кубите фликра
  int currentPage;

  PhotoDataToDisplay(this.photos, this.errorMessage, this.statusNotOkMessage, this.totalPages, {this.currentPage});

}