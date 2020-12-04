
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/domain/interactors/flickr_interactor.dart';
import 'package:flutter_internship_v2/presentation/models/photo_display_data.dart';
import 'package:flutter_internship_v2/presentation/models/net_parameters.dart';

part 'flickr_state.dart';


class FlickrCubit extends Cubit<FlickrState>{

  final FlickrInteractor flickInt;

  FlickrCubit({this.flickInt}) : super(FlickrInitialState());

  //Поле тэга поиска. По умолчанию waterfall
  String tag = "waterfall";
  //
  //Поле текущей страницы поиска
  int pageNumber = 1;

  //Выбор нового тэга. Так же идет сбрасывание текущей страницы
  setTag(String tag){
    this.tag = tag;
    this.pageNumber = 1;
  }

  //Либо смена тэга, либо первый запуск.
  Future<void> initiate() async {
    emit(FlickrLoadingState());
    await flickInt.fetchPhotos(NetParameters(
      tag: this.tag,
      page: this.pageNumber,
    ));
    final netData = flickInt.getAllInfo();
    netData.currentPage = pageNumber;
    if (netData.errorMessage != null || netData.statusNotOkMessage != null)
    emit(FlickrErrorState(netDataToDisplay: netData));
    else
    emit(FlickrUsageState(netDataToDisplay: netData));
  }

  //Подкачка дополнительных картинок
  Future<void> fetchMorePhotos() async {
    await flickInt.fetchPhotos(NetParameters(
      tag: this.tag,
      page: ++this.pageNumber,
    ));
    final netData = flickInt.getAllInfo();
    netData.currentPage = pageNumber;
    if (netData.errorMessage != null || netData.statusNotOkMessage != null)
      emit(FlickrErrorState(netDataToDisplay: netData));
    else
      emit(FlickrUsageState(netDataToDisplay: netData));
  }

}