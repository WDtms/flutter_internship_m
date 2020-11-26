import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'photos.dart';

List<Photo> parsePhotos(String responseBody) {
  final Map<String, dynamic> parsed = json.decode(responseBody);

  return List<Photo>.from(
    parsed["photos"]["photo"].map((x) => Photo.fromMap(x))
  );
}

class Requests{

  Future<List<Photo>> fetchPhotos(http.Client client) async {
    final response =
    await client.get('https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=18353747255e0f7e362243baf563348e&format=json&nojsoncallback=1');

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parsePhotos, response.body);
  }

// A function that converts a response body into a List<Photo>.

}