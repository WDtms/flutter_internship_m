import 'package:flutter_internship_v2/data/models/flickr_net_data.dart';
import 'package:flutter_internship_v2/data/models/image.dart';
import 'package:flutter_internship_v2/data/network/photo_net_api.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';

class PhotoNetStorage {

  PhotoNetApi _apiRequest;
  List<Photo> _allData;
  int _totalPages;
  String _statusNotOkMessage;
  String _errorMessage;

  List<Photo> get allPhotos => _allData;
  int get totalPages => _totalPages;
  String get statusNotOkMessage => _statusNotOkMessage;
  String get errorMessage => _errorMessage;

  void initData() {
    _allData = List<Photo>();
    _apiRequest = PhotoNetApi();
  }

  Future<void> fetchPhotos(NetParameters parameters) async{
    if (parameters.page == 1) {
      initData();
    }
    FlickrNetData flickrData = await _apiRequest.fetchPhotos(parameters);
    if (flickrData.statusNotOkMessage != null){
      _statusNotOkMessage = flickrData.statusNotOkMessage;
    }
    else if (flickrData.errorMessage != null){
      _errorMessage = flickrData.errorMessage;
    }
    else {
      _allData.addAll(flickrData.photos);
      _totalPages = flickrData.totalPages;
    }
  }

  void resetErrors(){
    _statusNotOkMessage = null;
    _errorMessage = null;
  }

}