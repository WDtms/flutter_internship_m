import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'photos.dart';

DataModel parsePhotos(String responseBody) {
  return DataModel.fromJson(json.decode(responseBody));
}

class Requests{

  final String web = "https://www.flickr.com";
  final String service = "services/rest/";
  final String getRecent = "flickr.photos.getRecent";
  final String apiKey = "18353747255e0f7e362243baf563348e";

  Future<DataModel> fetchPhotos(int page) async {
    final response =
    await http.Client().get('$web/$service?method=$getRecent'
        '&api_key=$apiKey&per_page=20&page=$page&format=json&nojsoncallback=1');

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parsePhotos, response.body);
  }

// A function that converts a response body into a List<Photo>.

}