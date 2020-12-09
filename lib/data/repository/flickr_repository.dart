import 'package:flutter_internship_v2/data/models/photo.dart';
import 'package:flutter_internship_v2/data/network/photo_net_storage.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';

class FlickrRepository {

  //Объект для работы с временным хранилищем картинок
  PhotoNetStorage _photoNetStorage = PhotoNetStorage();

  //Отправка запроса по заданным параметрам
  Future<void> fetchPhotos(NetParameters parameters) async {
    await _photoNetStorage.fetchPhotos(parameters);
  }

  //Получение сообщения об ошибке фликра
  String getStatusCode() {
    return _photoNetStorage.statusNotOkMessage;
  }

  //Получение всех картинок
  List<Photo> getAllPhotos() {
    return _photoNetStorage.allPhotos;
  }

  //Получение сообщения об ошибке http запроса
  String getErrorMessage() {
    return _photoNetStorage.errorMessage;
  }

  //Получение количества всех доступных во фликре страниц по запросу
  int getPagesCount() {
    return _photoNetStorage.totalPages;
  }

  //Сброс сообщений об ошибках
  resetErrors() {
    _photoNetStorage.resetErrors();
  }

}