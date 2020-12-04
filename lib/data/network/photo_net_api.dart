import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_internship_v2/data/models/flickr_net_data.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';
import 'package:http/http.dart' as http;

class PhotoNetApi {

  //Поля для отправки url запроса
  final String web = "https://www.flickr.com";
  final String service = "services/rest/";
  final String searchPhoto = "flickr.photos.search";
  final String apiKey = "18353747255e0f7e362243baf563348e";

  /*
  Преобразование информации, полученной из фликра, в объект. Обрабатывает
  как удачный, так и неудачный запрос.
   */
  static FlickrNetData parsePhotos(String responseBody) {
    if (json.decode(responseBody)['stat'] != "ok"){
      return FlickrNetData.fromFailedJson(json.decode(responseBody));
    }
    return FlickrNetData.fromSuccessJson(json.decode(responseBody));
  }

  /*
  Отправка запроса и получение ответа. Обрабатывает как удачный запрос,
  так и возникновение любой ошибки.
   */
  Future<FlickrNetData> fetchPhotos(NetParameters parameters) async {
    try {
      final response =
      await http.Client().get('$web/$service?method=$searchPhoto'
          '&api_key=$apiKey&tags=${parameters.tag}&per_page=20&page=${parameters
          .page}&format=json&nojsoncallback=1');
      return compute(parsePhotos, response.body);
    } catch (e) {
      return FlickrNetData(
        errorMessage: 'Проблемы с подключением',
      );
    }
  }
}