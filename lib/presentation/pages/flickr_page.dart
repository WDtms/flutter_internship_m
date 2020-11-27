import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/image.dart';
import 'package:flutter_internship_v2/data/network_storage.dart';
import 'package:flutter_internship_v2/data/repository/flickr_repository.dart';
import 'package:flutter_internship_v2/presentation/bloc/flickr/flickr_cubit.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';
import 'package:flutter_internship_v2/presentation/views/flickr_page/search_appbar.dart';

class FlickrPage extends StatefulWidget {

  final Map<Color, Color> theme;

  FlickrPage({this.theme});

  @override
  _FlickrPageState createState() => _FlickrPageState();
}

class _FlickrPageState extends State<FlickrPage> {

  ScrollController _scrollController;
  bool isSearching;
  int _page;
  FlickrCubit cubit;
  String _tag;


  @override
  void initState() {
    super.initState();
    isSearching = false;
    _tag = "";
    _scrollController = ScrollController();
    cubit = FlickrCubit(flickrRepository: FlickrRepository(networkStorage: NetworkStorage()));
    _page = 1;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        backgroundColor: widget.theme.values.toList().first,
        appBar: _buildAppBar(widget.theme.keys.toList().first),
        body: BlocBuilder<FlickrCubit, FlickrState>(
          builder: (context, state) {
            if (state is FlickrUsageState){
              _scrollController.addListener(() {
                if (_scrollController.position.pixels ==
                    _scrollController.position.maxScrollExtent) {
                  cubit.fetchPhotos(NetParameters(
                    page: ++_page,
                    tag: _tag,
                  ));
                }
              });
              return CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return _buildImage(state.photos[index]);
                        },
                        childCount: state.photos.length,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is FlickrInitialState) {
              cubit.initiate(
                  NetParameters(
                    page: _page,
                    tag: _tag,
                  )
              );
              return Center(child: CircularProgressIndicator());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
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
            _tag = "";
            _page = 1;
          });
          cubit.initiate(NetParameters(
            tag: _tag,
            page: _page,
          ));
        },
        onSubmitted: (String tag) {
          setState(() {
            _tag = tag;
            _page = 1;
          });
          cubit.initiate(NetParameters(
            page: _page,
            tag: tag,
          ));
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

}
