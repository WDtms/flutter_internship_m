

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_internship_v2/data/models/network_data.dart';

class ApiRequest{

  static NetworkData parsePhotos(String responseBody) {
    return NetworkData.fromSearchJson(json.decode(responseBody));
  }

  final String web = "https://www.flickr.com";
  final String service = "services/rest/";
  final String searchPhoto = "flickr.photos.search";
  final String apiKey = "18353747255e0f7e362243baf563348e";

  Future<NetworkData> fetchPhotos(NetParameters parameters) async {
    http.Response response;
    if (parameters.tag == "") {
      response =
      await http.Client().get('$web/$service?method=$searchPhoto'
          '&api_key=$apiKey&tags=waterfall&per_page=20&page=${parameters.page}&format=json&nojsoncallback=1');
      return compute(parsePhotos, response.body);
    } else {
      response =
      await http.Client().get('$web/$service?method=$searchPhoto'
          '&api_key=$apiKey&tags=${parameters.tag}&per_page=20&page=${parameters.page}&format=json&nojsoncallback=1');
      return compute(parsePhotos, response.body);
    }
  }

}