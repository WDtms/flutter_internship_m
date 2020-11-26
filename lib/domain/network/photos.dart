class DataModel {
  int totalImages;
  List<Photo> data;
  
  DataModel({this.totalImages, this.data});
  
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      totalImages: (json['photos']['total']).toInt(),
      data: (json['photos']['photo'] as List).map((photoInfo) => Photo.fromMap(photoInfo)).toList(),
    );
  }
  
}


class Photo {
  final String id;
  final String secret;
  final int farm;
  final String server;
  final String title;

  Photo({this.server, this.farm, this.secret, this.title, this.id});

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'] as String,
      secret: map['secret'] as String,
      farm: map['farm'] as int,
      server: map['server'] as String,
      title: map['title'] as String,
    );
  }
}