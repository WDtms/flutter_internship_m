import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/data/models/image.dart';
import 'package:flutter_internship_v2/data/repository/flickr_repository.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';
part 'flickr_state.dart';

class FlickrCubit extends Cubit<FlickrState> {

  final FlickrRepository flickrRepository;

  FlickrCubit({this.flickrRepository}) : super(FlickrInitialState());

  Future<void> initiate(NetParameters parameters) async {
    emit(FlickrLoadingState());
    await flickrRepository.fetchPhotos(parameters);
    final photos = await flickrRepository.getPhotosList();
    final totalCount = await flickrRepository.getTotalCount();
    emit(FlickrUsageState(photos: photos, totalCount: totalCount));
  }

  Future<void> fetchPhotos(NetParameters parameters) async {
    await flickrRepository.fetchPhotos(parameters);
    final photos = await flickrRepository.getPhotosList();
    final totalCount = await flickrRepository.getTotalCount();
    emit(FlickrUsageState(photos: photos, totalCount: totalCount));
  }

}