import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ShopAppCubit extends Cubit<ShopAppState> {

  ShopAppCubit() : super(ShopAppInitState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  int currentIndex  = 0;

  void changeBottomNavBar ({required int index}) {
    currentIndex = index;
    emit(ShopAppChangeNavBarState());
  }
}
