import 'package:flutter_internship_v2/data/models/image.dart';
import 'package:flutter_internship_v2/data/network_storage.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';

class FlickrRepository{

  final NetworkStorage networkStorage;

  FlickrRepository({this.networkStorage});

  Future<void> fetchPhotos(NetParameters parameters) async {
    await networkStorage.fetchPhotos(parameters);
  }

  Future<List<Photo>> getPhotosList() async {
    return await networkStorage.allPhotos;
  }

  Future<int> getTotalCount() async {
    return await networkStorage.totalCount;
  }
}