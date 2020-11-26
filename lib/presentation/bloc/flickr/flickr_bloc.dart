import 'package:flutter/cupertino.dart';
import 'package:flutter_internship_v2/domain/network/photos.dart';
import 'package:flutter_internship_v2/domain/network/request.dart';

enum LoadMoreStatus {LOADING, STABLE}

class DataProvider with ChangeNotifier {

  Requests _requests;
  DataModel _dataModel;
  int totalPages = 0;
  int pageSize = 20;

  List<Photo> get allPhotos => _dataModel.data;
  double get totalRecords => _dataModel.totalImages.toDouble();

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;
  getLoadMoreStatus() => _loadMoreStatus;

  DataProvider() {
    _initStreams();
  }

  void _initStreams() {
    _requests = Requests();
    _dataModel = DataModel();
  }

  void resetStreams() {
    _initStreams();
  }

  fetchAllPhotos(int page) async {
    if ((totalPages == 0) || page <= totalPages){
      DataModel itemModel =
          await _requests.fetchPhotos(page);
      if (_dataModel.data == null) {
        totalPages = ((itemModel.totalImages - 1)/pageSize).ceil();
        _dataModel = itemModel;
      } else {
        _dataModel.data.addAll(itemModel.data);
        _dataModel = _dataModel;

        setLoadingState(LoadMoreStatus.STABLE);
      }
    }

    notifyListeners();
  }

  setLoadingState(LoadMoreStatus loadMoreStatus){
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }
}