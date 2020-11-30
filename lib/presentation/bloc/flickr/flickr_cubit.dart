import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/image.dart';
import 'package:flutter_internship_v2/data/repository/flickr_repository.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';
part 'flickr_state.dart';

class FlickrCubit extends Cubit<FlickrState> {

  final FlickrRepository flickrRepository;

  FlickrCubit({this.flickrRepository}) : super(FlickrInitialState());

  String tag = "";
  int pageNumber = 1;

  setTag(String tag){
    this.tag = tag;
    this.pageNumber = 1;
  }

  resetTag() async {
    if (this.tag != "") {
      this.tag = "";
      this.pageNumber = 1;
      await initiate();
    }
  }

  Future<void> initiate() async {
    emit(FlickrLoadingState());
    await flickrRepository.initFetchPhotos(NetParameters(
      page: this.pageNumber,
      tag: this.tag,
    ));
    final photos = await flickrRepository.getPhotosList();
    final totalCount = await flickrRepository.getTotalCount();
    emit(FlickrUsageState(photos: photos, totalCount: totalCount, tag: ""));
  }

  Future<void> fetchPhotos() async {
    await flickrRepository.fetchPhotos(NetParameters(
      page: ++this.pageNumber,
      tag: this.tag,
    ));
    final photos = await flickrRepository.getPhotosList();
    final totalCount = await flickrRepository.getTotalCount();
    emit(FlickrUsageState(photos: photos, totalCount: totalCount, tag: tag));
  }

}