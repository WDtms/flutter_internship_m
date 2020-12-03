import 'package:flutter_bloc/flutter_bloc.dart';

class MyCubitObserver extends BlocObserver{
  @override
  void onCreate(Cubit cubit) {
    print('create');
    super.onCreate(cubit);
  }
  @override
  void onClose(Cubit cubit) {
    print('closed');
    super.onClose(cubit);
  }
}