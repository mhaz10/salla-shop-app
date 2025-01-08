import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/state.dart';

import '../../../models/login/login_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterState>{

  RegisterCubit() : super (RegisterInitState());


  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? userData;


  void userRegister ({required String name, required String phone, required String email, required String password}) {

    emit(RegisterLoadingState());

    DioHelper.postData(url: REGISTER, data: {
      'name' : name,
      'phone' : phone,
      'email' : email,
      'password' : password,
    }).then((value) {
      userData = LoginModel.fromJson(value.data);
      print(userData!.message);
      emit(RegisterSuccessState(userData!));
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  Icon suffixIcon = Icon(Icons.visibility_off);
  bool visiblePassword = true;

  void changePasswordVisibility () {
    visiblePassword = !visiblePassword;
    suffixIcon = visiblePassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility);
    emit(RegisterChangePasswordVisibilityState());
  }
}