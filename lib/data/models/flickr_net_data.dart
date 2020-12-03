import 'package:flutter_internship_v2/data/models/image.dart';

class FlickrNetData{

  final String errorMessage;
  final String statusNotOkMessage;
  final int totalPages;
  final List<Photo> photos;

  FlickrNetData({this.errorMessage, this.statusNotOkMessage, this.totalPages, this.photos});

  factory FlickrNetData.fromSuccessJson(Map<String, dynamic> json) {
    return FlickrNetData(
      totalPages: json['photos']['pages'] as int,
      photos: (json['photos']['photo'] as List).map((photoInfo) => Photo.fromMap(photoInfo)).toList(),
    );
  }

  factory FlickrNetData.fromFailedJson(Map<String, dynamic> json) {
    return FlickrNetData(
      statusNotOkMessage: json['message'],
    );
  }

}