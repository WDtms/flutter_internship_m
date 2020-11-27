import 'package:flutter_internship_v2/data/models/image.dart';

class NetworkData {

  int totalImages;
  List<Photo> data;

  NetworkData({this.totalImages, this.data});

  factory NetworkData.fromJson(Map<String, dynamic> json) {
    return NetworkData(
      totalImages: json['photos']['total'] as int,
      data: (json['photos']['photo'] as List).map((photoInfo) => Photo.fromMap(photoInfo)).toList(),
    );
  }

  factory NetworkData.fromSearchJson(Map<String, dynamic> json) {
    return NetworkData(
      totalImages: int.parse(json['photos']['total'] as String),
      data: (json['photos']['photo'] as List).map((photoInfo) => Photo.fromMap(photoInfo)).toList(),
    );
  }

}