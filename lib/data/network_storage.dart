import 'package:flutter_internship_v2/data/api.dart';
import 'package:flutter_internship_v2/data/models/image.dart';
import 'package:flutter_internship_v2/data/models/network_data.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';

class NetworkStorage{

  bool _isSearching = false;
  ApiRequest _apiRequest;
  List<Photo> _allData;
  int _totalCount;
  String _tag;

  NetworkStorage() {
    initData();
  }

  List<Photo> get allPhotos => _allData;
  int get totalCount => _totalCount;

  void initData() {
    _allData = List<Photo>();
    _apiRequest = ApiRequest();
  }

  Future<void> fetchPhotos(NetParameters parameters) async{
    if (parameters.tag != ""){
      if (!_isSearching) {
        _isSearching = true;
        initData();
      }
      if (parameters.tag != _tag)
        initData();
    } else {
      if (_isSearching){
        _isSearching = false;
        initData();
      }
    }
    if (_allData.length == 0){
      NetworkData networkData = await _apiRequest.fetchPhotos(parameters);
      _allData.addAll(networkData.data);
      _totalCount = networkData.totalImages;
    }
    else {
      _allData.addAll((await _apiRequest.fetchPhotos(parameters)).data);
    }
  }

}