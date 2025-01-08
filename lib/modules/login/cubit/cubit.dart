import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../../models/login/login_model.dart';
import '../../../shared/network/end_points.dart';

class LoginCubit extends Cubit<LoginState>{

  LoginCubit() : super (LoginInitState());


  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? userData;


  void userLogin ({required String email, required String password}) {

    emit(LoginLoadingState());

    DioHelper.postData(url: LOGIN, data: {
      'email' : email,
      'password' : password,
    }).then((value) {
      userData = LoginModel.fromJson(value.data);
      print(userData!.message);
      emit(LoginSuccessState(userData!));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  Icon suffixIcon = Icon(Icons.visibility_off);
  bool visiblePassword = true;

  void changePasswordVisibility () {
    visiblePassword = !visiblePassword;
    suffixIcon = visiblePassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility);
    emit(LoginChangePasswordVisibilityState());
  }
}