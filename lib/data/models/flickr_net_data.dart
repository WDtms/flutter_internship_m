import 'package:flutter_internship_v2/data/models/photo.dart';

class FlickrNetData{

  //Любое выбрасываемое исключение в процессе обращения к интернет ресурсу
  final String errorMessage;
  //
  //Сообщение, получаемое при неправильном запросе
  final String statusNotOkMessage;
  //
  //Общее число страниц
  final int totalPages;
  //
  //Список полученных фото (из 20 объектов)
  final List<Photo> photos;

  //Конструктор
  FlickrNetData({this.errorMessage, this.statusNotOkMessage, this.totalPages, this.photos});

  /*
  Преобразование данных, полученных из фликра при удачном запросе,
  в объект
   */
  factory FlickrNetData.fromSuccessJson(Map<String, dynamic> json) {
    return FlickrNetData(
      totalPages: json['photos']['pages'] as int,
      photos: (json['photos']['photo'] as List).map((photoInfo) => Photo.fromMap(photoInfo)).toList(),
    );
  }

  /*
  Преобразование данных, полученных из фликра при неудачном запросе,
  в объект
   */
  factory FlickrNetData.fromFailedJson(Map<String, dynamic> json) {
    return FlickrNetData(
      statusNotOkMessage: json['message'],
    );
  }

}