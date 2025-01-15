import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/%20bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'layout/layout.dart';
import 'modules/onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  if ( CacheHelper.getData(key: 'token') != null){
    TOKEN = CacheHelper.getData(key: 'token');
  }

  runApp(const MyApp());
}


Widget startScreen() {
  if (CacheHelper.getData(key: 'onboarding') != null) {
    if (CacheHelper.getData(key: 'token') != null) {
      return HomeLayout();
    } else {
      return LoginScreen();
    }
  } else {
    return OnboardingScreen();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAppCubit()
        ..getHomeData()
        ..getProfile(fromShared: CacheHelper.getData(key: 'userData'))
        ..changeThemeMode(isDark: CacheHelper.getData(key: 'isDark'))
        ..changeAppLanguage(fromShared: CacheHelper.getData(key: 'lang')),
      child: BlocConsumer<ShopAppCubit, ShopAppState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ShopAppCubit.get(context).themeData,
        home: startScreen(),
      );
  },
),
    );
  }
}




