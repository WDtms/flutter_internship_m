
part of 'flickr_cubit.dart';

@immutable
abstract class FlickrState{}

class FlickrInitialState extends FlickrState{

}

class FlickrLoadingState extends FlickrState{

}

class FlickrUsageState extends FlickrState{
  final String tag;
  final List<Photo> photos;
  final int totalCount;

  FlickrUsageState({this.photos, this.totalCount, this.tag});
}