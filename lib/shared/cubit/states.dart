import 'package:shop_app/models/change_favorites/change_favorites.dart';
import 'package:shop_app/models/login/login_model.dart';

abstract class ShopAppState {}

class ShopAppInitState extends ShopAppState {}

class ShopAppChangeNavBarState extends ShopAppState {}


class ShopAppLoadingHomeState extends ShopAppState {}

class ShopAppSuccessHomeState extends ShopAppState {}

class ShopAppErrorHomeState extends ShopAppState {}


class ShopAppChangeFavoritesState extends ShopAppState {}

class ShopAppSuccessChangeFavoritesState extends ShopAppState {
  final ChangeFavoritesModel changeFavoritesModel;

  ShopAppSuccessChangeFavoritesState(this.changeFavoritesModel);
}

class ShopAppErrorChangeFavoritesState extends ShopAppState {}


class ShopAppLoadingFavoritesState extends ShopAppState {}

class ShopAppSuccessFavoritesState extends ShopAppState {}

class ShopAppErrorFavoritesState extends ShopAppState {}


class ShopAppSuccessCategoryState extends ShopAppState {}

class ShopAppErrorCategoryState extends ShopAppState {}


class ShopAppLoadingProfileState extends ShopAppState {}

class ShopAppSuccessProfileState extends ShopAppState {}

class ShopAppErrorProfileState extends ShopAppState {
  final String error;

  ShopAppErrorProfileState(this.error);
}


class ShopAppLoadingUpdateState extends ShopAppState {}

class ShopAppSuccessUpdateState extends ShopAppState {
  final LoginModel loginModel;

  ShopAppSuccessUpdateState(this.loginModel);
}

class ShopAppErrorUpdateState extends ShopAppState {
  final String error;

  ShopAppErrorUpdateState(this.error);
}


class ShopAppSuccessLogoutState extends ShopAppState {}

class ShopAppErrorLogoutState extends ShopAppState {}