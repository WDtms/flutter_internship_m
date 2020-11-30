import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_internship_v2/data/models/image.dart';
import 'package:flutter_internship_v2/data/photo_net_storage.dart';
import 'package:flutter_internship_v2/data/repository/flickr_repository.dart';
import 'package:flutter_internship_v2/presentation/bloc/flickr/flickr_cubit.dart';
import 'package:flutter_internship_v2/presentation/views/flickr_page/flickr_appbar.dart';

class FlickrPage extends StatefulWidget {

  final Map<Color, Color> theme;
  final Function(String filePath) addImage;

  FlickrPage({this.theme, this.addImage});

  @override
  _FlickrPageState createState() => _FlickrPageState();
}

class _FlickrPageState extends State<FlickrPage> {

  ScrollController _scrollController;
  FlickrCubit cubit;

  @override
  void initState() {
    cubit = FlickrCubit(flickrRepository: FlickrRepository(networkStorage: PhotoNetStorage()));
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        cubit.fetchPhotos();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        backgroundColor: widget.theme.values.toList().first,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: FlickrAppBar(
            appBarColor: widget.theme.keys.toList().first,
            searchPhotos: (String searchTag) {
              cubit.setTag(searchTag);
              cubit.initiate();
            },
            reset: () {
              cubit.resetTag();
            },
          ),
        ),
        body: BlocBuilder<FlickrCubit, FlickrState>(
          builder: (context, state) {
            if (state is FlickrUsageState){
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
              cubit.initiate();
              return Center(child: CircularProgressIndicator());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildImage(Photo photo) {
    return CachedNetworkImage(
      imageUrl: photo.photoURL,
      imageBuilder: (context, imageProvider) => InkWell(
        child: Image(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
        onTap: () async {
          final file = await DefaultCacheManager().getSingleFile(photo.photoURL);
          String filePath = file.path;
          widget.addImage(filePath);
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
