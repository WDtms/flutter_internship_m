import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/domain/network/photos.dart';
import 'package:flutter_internship_v2/presentation/bloc/flickr/flickr_bloc.dart';
import 'package:flutter_internship_v2/presentation/views/flickr_page/search_appbar.dart';
import 'package:provider/provider.dart';

class FlickrPage extends StatefulWidget {

  final Map<Color, Color> theme;

  FlickrPage({this.theme});

  @override
  _FlickrPageState createState() => _FlickrPageState();
}

class _FlickrPageState extends State<FlickrPage> {

  ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool isLoading = false;
  bool isSearching = false;


  @override
  void initState() {
    super.initState();

    var photoBloc = Provider.of<DataProvider>(context, listen: false);
    photoBloc.resetStreams();
    photoBloc.fetchAllPhotos(_page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        photoBloc.setLoadingState(LoadMoreStatus.LOADING);
        photoBloc.fetchAllPhotos(++_page);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.values.toList().first,
      appBar: _buildAppBar(widget.theme.keys.toList().first),
      body: Consumer<DataProvider>(
        builder: (context, usersModel, child) {
          if (usersModel.allPhotos != null && usersModel.allPhotos.length > 0){
            return _gridView(usersModel);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _gridView(DataProvider dataProvider){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: dataProvider.allPhotos.length,
      itemBuilder: (context, index) {
        if ((index == dataProvider.allPhotos.length - 1) && 
            dataProvider.allPhotos.length < dataProvider.totalRecords) {
          return Center(child: CircularProgressIndicator());
        }
        
        return _buildImage(dataProvider.allPhotos[index]);
      },
    );
  }
  
  Widget _buildImage(Photo photo) {
    return Image.network(
      'https://farm${photo.farm}.staticflickr.com/${photo.server}/${photo.id}_${photo.secret}.jpg',
      fit: BoxFit.cover,
    );
  }
  
  Widget _buildAppBar(Color appBarColor) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: !isSearching ?
      AppBar(
        title: Text('Flickr'),
        backgroundColor: appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                isSearching = true;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.wifi),
            onPressed: () {

            },
          ),
        ],
      ) : SearchAppBar(
        appBarColor: appBarColor,
        setBoolToFalse: () {
          setState(() {
            isSearching = false;
          });
        },
      ),
    );
  }
}
