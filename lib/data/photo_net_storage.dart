import 'package:flutter_internship_v2/data/api.dart';
import 'package:flutter_internship_v2/data/models/image.dart';
import 'package:flutter_internship_v2/data/models/network_data.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';

class PhotoNetStorage{

  ApiRequest _apiRequest;
  List<Photo> _allData;
  int _totalCount;

  List<Photo> get allPhotos => _allData;
  int get totalCount => _totalCount;

  void initData() {
    _allData = List<Photo>();
    _apiRequest = ApiRequest();
  }

  Future<void> fetchPhotos(NetParameters parameters) async{
    _allData.addAll((await _apiRequest.fetchPhotos(parameters)).data);
  }

  Future<void> initFetchPhotos(NetParameters parameters) async{
    initData();
    NetworkData networkData = await _apiRequest.fetchPhotos(parameters);
    _allData.addAll(networkData.data);
    _totalCount = networkData.totalImages;
  }

}