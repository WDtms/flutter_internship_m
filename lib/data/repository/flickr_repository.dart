import 'package:flutter_internship_v2/data/models/image.dart';
import 'package:flutter_internship_v2/data/photo_net_storage.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';

class FlickrRepository{

  final PhotoNetStorage networkStorage;

  FlickrRepository({this.networkStorage});

  Future<void> fetchPhotos(NetParameters parameters) async {
    await networkStorage.fetchPhotos(parameters);
  }

  Future<void> initFetchPhotos(NetParameters parameters) async {
    await networkStorage.initFetchPhotos(parameters);
  }

  Future<List<Photo>> getPhotosList() async {
    return await networkStorage.allPhotos;
  }

  Future<int> getTotalCount() async {
    return await networkStorage.totalCount;
  }
}