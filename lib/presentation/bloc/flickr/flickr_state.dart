part of 'flickr_cubit.dart';

abstract class FlickrState{
  PhotoDataToDisplay netDataToDisplay;
}

class FlickrInitialState extends FlickrState{

}

class FlickrLoadingState extends FlickrState{

}

class FlickrErrorState extends FlickrState{
  final PhotoDataToDisplay netDataToDisplay;

  FlickrErrorState({this.netDataToDisplay});
}

class FlickrUsageState extends FlickrState{
  final PhotoDataToDisplay netDataToDisplay;

  FlickrUsageState({this.netDataToDisplay});
}