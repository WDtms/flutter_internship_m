import 'dart:convert';
import 'dart:io';
import 'package:flutter_internship_v2/data/network/photo_net_api.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

void main() {

  group('fetchPhotos', () {

    const _flickrPhoto = {
      "id" : "",
      "secret" : "",
      "server" : "",
      "farm" : 1,
      "title" : "",
    };

    const _flickrPhotos = {
      "pages" : 1,
      "photo" : [_flickrPhoto],
    };

    const _flickrSucceedResponse = {
      "photos" : _flickrPhotos,
      "stat" : "ok",
    };

    const _flickrFailedResponse = {
      "stat": "fail",
      "message" : "Wrong parameters",
    };

    PhotoNetApi _photoNetApi;
    http.Client _httpClient;

    setUp(() {
      _httpClient = MockClient();
      _photoNetApi = PhotoNetApi(_httpClient);
    });

    test('Получение списка картинок при удачном запросе во Flickr', () async{

      when(_httpClient.get(any)).thenAnswer((_) async => http.Response(
        jsonEncode(_flickrSucceedResponse),
        HttpStatus.ok,
      ));

      final decodeNetResponse = await _photoNetApi.fetchPhotos(NetParameters(1, '1'));

      expect(decodeNetResponse.photos != null, true);

    });

    test('Получение сообщения от Flickr при неудачном запросе', () async {

      when(_httpClient.get(any)).thenAnswer((_) async => http.Response(
        jsonEncode(_flickrFailedResponse),
        HttpStatus.ok,
      ));

      final decodeNetResponse = await _photoNetApi.fetchPhotos(NetParameters(1, '1'));

      expect(decodeNetResponse.statusNotOkMessage != null, true);

    });

    test('Обработка исключения при проблемах с сетью', () async {

      when(_httpClient.get(any)).thenThrow(SocketException('asdasd'));

      final decodeNetResponse = await _photoNetApi.fetchPhotos(NetParameters(1, '1'));

      expect(decodeNetResponse.errorMessage != null, true);

    });


  });

}