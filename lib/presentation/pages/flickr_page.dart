import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/domain/network/photos.dart';
import 'package:flutter_internship_v2/domain/network/request.dart';
import 'package:http/http.dart' as http;

class FlickrPage extends StatefulWidget {

  @override
  _FlickrPageState createState() => _FlickrPageState();
}

class _FlickrPageState extends State<FlickrPage> {

  Requests request = Requests();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('asdas'),
      ),
      body: FutureBuilder<List<Photo>>(
        future: Requests().fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData ?
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                controller: ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: snapshot.data.map((e) {
                  return Image.network(
                    'https://farm${e.farm}.staticflickr.com/${e.server}/${e.id}_${e.secret}.jpg',
                    fit: BoxFit.fill,
                  );
                }).toList(),
              ) : CircularProgressIndicator();
        },
      ),
    );
  }
}
