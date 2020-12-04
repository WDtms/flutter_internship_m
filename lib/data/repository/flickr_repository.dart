import 'package:flutter_internship_v2/data/network/photo_net_storage.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';

class FlickrRepository {

  //Объект для работы с временным хранилищем картинок
  PhotoNetStorage photoNetStorage = PhotoNetStorage();

  //Отправка запроса по заданным параметрам
  Future<void> fetchPhotos(NetParameters parameters) async {
    await photoNetStorage.fetchPhotos(parameters);
  }

  //Получение сообщения об ошибке фликра
  getStatusCode() {
    return photoNetStorage.statusNotOkMessage;
  }

  //Получение всех картинок
  getAllPhotos() {
    return photoNetStorage.allPhotos;
  }

  //Получение сообщения об ошибке http запроса
  getErrorMessage() {
    return photoNetStorage.errorMessage;
  }

  //Получение количества всех доступных во фликре страниц по запросу
  getPagesCount() {
    return photoNetStorage.totalPages;
  }

  //Сброс сообщений об ошибках
  resetErrors() {
    photoNetStorage.resetErrors();
  }

}