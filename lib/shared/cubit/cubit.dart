import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories/category.model.dart';
import 'package:shop_app/models/change_favorites/change_favorites.dart';
import 'package:shop_app/models/favorites/favorites_model.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
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

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopAppLoadingHomeState());

    DioHelper.getData(url: HOME, token: TOKEN).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // homeModel!.data!.products.forEach(
      //   (element) => favorites!.addAll({ element.id! : element.inFavorites! }),
      // );

      for(final element in homeModel!.data!.products ) {
        //  favorites[element.id!] = element.inFavorites!;
        favorites.addAll({ element.id! : element.inFavorites! });
      }


      emit(ShopAppSuccessHomeState());
    }).catchError((error){
      print(error.toString());
      emit(ShopAppErrorHomeState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites ({required int productId}) {

    favorites[productId] = !favorites[productId]!;
    emit(ShopAppChangeFavoritesState());
    
    DioHelper.postData(url: FAVORITES, token: TOKEN ,data: {"product_id": productId}).then((value){
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }

      emit(ShopAppSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error){
      favorites[productId] = !favorites[productId]!;
      print(error.toString());
      emit(ShopAppErrorChangeFavoritesState());
    });
    
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopAppLoadingFavoritesState());

    DioHelper.getData(url: FAVORITES, token: TOKEN).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopAppSuccessFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopAppErrorFavoritesState());
    });
  }


  CategoryModel? categoryModel;

  void getCategories() {

    DioHelper.getData(url: CATEGORIES).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      print(value.data);
      print(categoryModel!.categoryData!.data[0].name);
      emit(ShopAppSuccessCategoryState());
    }).catchError((error){
      print(error.toString());
      emit(ShopAppErrorCategoryState());
    });
  }

  LoginModel? userData;

  void getProfile () {

    emit(ShopAppLoadingProfileState());

    DioHelper.getData(url: PROFILE, token: TOKEN).then((value) {
      userData = LoginModel.fromJson(value.data);
      emit(ShopAppSuccessProfileState());
    }).catchError((error){
      print(error.toString());
      emit(ShopAppErrorProfileState(error.toString()));
    });

  }

  void updateProfile ({required String name, required String phone, required String email}) {

    emit(ShopAppLoadingUpdateState());

    DioHelper.putData(url: UPDATE, token: TOKEN, data: {"name": name, "phone": phone, "email": email,})
        .then((value) {
      userData = LoginModel.fromJson(value.data);
      emit(ShopAppSuccessUpdateState(userData!));
    }).catchError((error){
      print(error.toString());
      emit(ShopAppErrorUpdateState(error.toString()));
    });

  }

  void Logout () {

    DioHelper.postData(url: LOGOUT, token: TOKEN).then((value) {
      emit(ShopAppSuccessLogoutState());
    }).catchError((error){
      print(error.toString());
      emit(ShopAppErrorLogoutState());
    });

  }
}
