import 'package:flutter_internship_v2/data/models/photo.dart';
import 'package:flutter_internship_v2/domain/interactors/flickr_interactor.dart';
import 'package:flutter_internship_v2/presentation/bloc/flickr/flickr_cubit.dart';
import 'package:flutter_internship_v2/presentation/models/photo_display_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

class MockFlickrInteractor extends Mock implements FlickrInteractor{}

void main() {

  group('FlickrCubit', () {

    FlickrInteractor _flickrInteractor;
    List<Photo> _photos = [
      Photo(),
    ];
    PhotoDataToDisplay _photoDataToDisplaySuccess = PhotoDataToDisplay(_photos, null, null, 2);
    PhotoDataToDisplay _photoDataToDisplayFailed = PhotoDataToDisplay(_photos, 'fail', null, 2);

    setUp(() {
      _flickrInteractor = MockFlickrInteractor();
    });

    blocTest(
        'Инициализация или реинициализация при удачном запросе',
        build: () {
          when(_flickrInteractor.fetchPhotos(any)).thenReturn(null);
          when(_flickrInteractor.getAllInfo()).thenReturn(_photoDataToDisplaySuccess);
          return FlickrCubit(flickInt: _flickrInteractor);
        },
      act: (FlickrCubit cubit) => cubit.initiate(),
      expect: [
        isA<FlickrLoadingState>(),
        isA<FlickrUsageState>(),
      ],
      verify: (_) {
          verify(_flickrInteractor.fetchPhotos(any));
          verify(_flickrInteractor.getAllInfo());
      },
    );

    blocTest(
      'Инициализация или реинициализация при неудачном запросе',
      build: () {
        when(_flickrInteractor.fetchPhotos(any)).thenReturn(null);
        when(_flickrInteractor.getAllInfo()).thenReturn(_photoDataToDisplayFailed);
        return FlickrCubit(flickInt: _flickrInteractor);
      },
      act: (FlickrCubit cubit) => cubit.initiate(),
      expect: [
        isA<FlickrLoadingState>(),
        isA<FlickrErrorState>(),
      ],
      verify: (_) {
        verify(_flickrInteractor.fetchPhotos(any));
        verify(_flickrInteractor.getAllInfo());
      },
    );

    blocTest(
      'Подгрузка при удачном запросе',
      build: () {
        when(_flickrInteractor.fetchPhotos(any)).thenReturn(null);
        when(_flickrInteractor.getAllInfo()).thenReturn(_photoDataToDisplaySuccess);
        return FlickrCubit(flickInt: _flickrInteractor);
      },
      act: (FlickrCubit cubit) => cubit.fetchMorePhotos(),
      expect: [
        isA<FlickrUsageState>(),
      ],
      verify: (_) {
        verify(_flickrInteractor.fetchPhotos(any));
        verify(_flickrInteractor.getAllInfo());
      },
    );

    blocTest(
      'Подгрузка при неудачном запросе',
      build: () {
        when(_flickrInteractor.fetchPhotos(any)).thenReturn(null);
        when(_flickrInteractor.getAllInfo()).thenReturn(_photoDataToDisplayFailed);
        return FlickrCubit(flickInt: _flickrInteractor);
      },
      act: (FlickrCubit cubit) => cubit.fetchMorePhotos(),
      expect: [
        isA<FlickrErrorState>(),
      ],
      verify: (_) {
        verify(_flickrInteractor.fetchPhotos(any));
        verify(_flickrInteractor.getAllInfo());
      },
    );

  });

}