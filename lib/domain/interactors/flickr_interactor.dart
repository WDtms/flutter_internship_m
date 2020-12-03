import 'package:flutter_internship_v2/data/repository/flickr_repository.dart';
import 'package:flutter_internship_v2/presentation/models/photo_display_data.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';

class FlickrInteractor {
  
  FlickrRepository flickRep = FlickrRepository();
  
  Future<void> fetchPhotos(NetParameters parameters) async {
    await flickRep.fetchPhotos(parameters);
  }
  
  PhotoDataToDisplay getAllInfo() {
    final statusNotOkMessage = flickRep.getStatusCode();
    final errorMessage = flickRep.getErrorMessage();
    if (errorMessage != null || statusNotOkMessage != null)
      flickRep.resetErrors();
    return PhotoDataToDisplay(
      statusNotOkMessage: statusNotOkMessage,
      errorMessage: errorMessage,
      totalPages: flickRep.getPagesCount(),
      photos: flickRep.getAllPhotos(),
    );
  }
  
}