
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/domain/interactors/flickr_interactor.dart';
import 'package:flutter_internship_v2/presentation/bloc/flickr/flickr_cubit.dart';
import 'package:flutter_internship_v2/presentation/models/photo_display_data.dart';
import 'package:flutter_internship_v2/presentation/views/flickr_page/flickr_appbar.dart';
import 'package:flutter_internship_v2/presentation/views/flickr_page/image.dart';

class FlickrPage extends StatefulWidget {

  final Map<Color, Color> theme;
  final Function(String filePath) addImage;

  FlickrPage({this.theme, this.addImage});

  @override
  _FlickrPageState createState() => _FlickrPageState();
}

class _FlickrPageState extends State<FlickrPage> {

  ScrollController _scrollController;
  FlickrCubit fliCu;
  VoidCallback listener;

  @override
  void initState() {
    fliCu = FlickrCubit(flickInt: FlickrInteractor());
    super.initState();
    _scrollController = ScrollController();
    listener = () {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fliCu.fetchMorePhotos();
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => fliCu,
      child: Scaffold(
        backgroundColor: widget.theme.values.toList().first,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: FlickrAppBar(
            appBarColor: widget.theme.keys.toList().first,
            searchPhotos: (String searchTag) {
              if (searchTag != "") {
                fliCu.setTag(searchTag);
                fliCu.initiate();
              }
            },
          ),
        ),
        body: BlocListener<FlickrCubit, FlickrState>(
          listenWhen: (previousState, currentState) {
            if (previousState is FlickrErrorState || previousState is FlickrLoadingState) {
              return true;
            }
            else if (currentState is FlickrErrorState) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            if (state is FlickrErrorState)
              // ignore: invalid_use_of_protected_member
              if (_scrollController.hasListeners)
                _scrollController.removeListener(listener);
            if (state is FlickrUsageState)
              _scrollController.addListener(listener);
          },
          child: BlocBuilder<FlickrCubit, FlickrState>(
            builder: (context, state) {
              if (state is FlickrUsageState || state is FlickrErrorState){
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
                          return ImageDisplay(photoURL: state.netDataToDisplay.photos[index].photoURL, addImage: widget.addImage, iconColor: widget.theme.keys.toList().first);
                          },
                          childCount: state.netDataToDisplay.photos.length,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: Center(
                          child: _decideWhatToDisplay(state, state.netDataToDisplay),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is FlickrInitialState) {
                fliCu.initiate();
                return Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(widget.theme.keys.toList().first,),
                ));
              }
              return Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(widget.theme.keys.toList().first,),
              ));
            },
          ),
        ),
      ),
    );
  }

  Widget _decideWhatToDisplay(FlickrState state, PhotoDataToDisplay netDataToDisplay){
    if (state is FlickrErrorState && netDataToDisplay.statusNotOkMessage != null)
      return Text(netDataToDisplay.statusNotOkMessage);
    else if (state is FlickrErrorState && netDataToDisplay.errorMessage != null)
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            Center(
                child: Text(
                    'Что-то пошло не так.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: Text(
                    'Проверьте подключение к сети.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            RaisedButton(
              child: Text(
                'Попробовать еще',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
              ),
              onPressed: () {
                fliCu.fetchMorePhotos();
              },
              color: widget.theme.keys.toList().first,
            ),
          ],
        ),
      );
    else if (netDataToDisplay.currentPage >= netDataToDisplay.totalPages)
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          'Это все картинки по вашему запросу',
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18
          ),
        ),
      );
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(widget.theme.keys.toList().first),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

}
