import 'package:flutter_internship_v2/data/models/flickr_net_data.dart';
import 'package:flutter_internship_v2/data/models/image.dart';
import 'package:flutter_internship_v2/data/network/photo_net_api.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';

class PhotoNetStorage {

  //Объект для отправки запросов в фликр
  PhotoNetApi _apiRequest;
  //
  //Список всех хранящихся на данный момент картинок
  List<Photo> _allData;
  //
  //Количество всех страниц
  int _totalPages;
  //
  //Сообщение при неправильном запросе в фликр
  String _statusNotOkMessage;
  //
  //Сообщение при ошибке http запроса
  String _errorMessage;

  //Геттеры полей
  List<Photo> get allPhotos => _allData;
  int get totalPages => _totalPages;
  String get statusNotOkMessage => _statusNotOkMessage;
  String get errorMessage => _errorMessage;

  //Инициализация или обновление списка
  void initData() {
    _allData = List<Photo>();
    _apiRequest = PhotoNetApi();
  }

  //Подтягивание информации по запросу
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

  //Сброс сообщений об ошибке после их обработки
  void resetErrors(){
    _statusNotOkMessage = null;
    _errorMessage = null;
  }

}