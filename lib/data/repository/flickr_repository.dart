import 'package:flutter_internship_v2/data/network/photo_net_storage.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';

class FlickrRepository {

  PhotoNetStorage photoNetStorage = PhotoNetStorage();

  Future<void> fetchPhotos(NetParameters parameters) async {
    await photoNetStorage.fetchPhotos(parameters);
  }

  getStatusCode() {
    return photoNetStorage.statusNotOkMessage;
  }

  getAllPhotos() {
    return photoNetStorage.allPhotos;
  }

  getErrorMessage() {
    return photoNetStorage.errorMessage;
  }

  getPagesCount() {
    return photoNetStorage.totalPages;
  }

  resetErrors() {
    photoNetStorage.resetErrors();
  }

}