import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../components/constants.dart';
import '../network/end_points.dart';

class ShopAppCubit extends Cubit<ShopAppState> {

  ShopAppCubit() : super(ShopAppInitState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  int currentIndex  = 0;

  void changeBottomNavBar ({required int index}) {
    currentIndex = index;
    emit(ShopAppChangeNavBarState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopAppLoadingHomeState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      print(homeModel!.data!.products[0].name);
      print(homeModel!.data!.products[0].id);
      print(homeModel!.data!.products[0].price);
      print(homeModel!.data!.products[0].oldPrice);

      emit(ShopAppSuccessHomeState());
    }).catchError((error){
      print(error.toString());
      emit(ShopAppErrorHomeState());
    });
  }
}
