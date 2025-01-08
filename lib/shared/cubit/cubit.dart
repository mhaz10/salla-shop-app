import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ShopCubit extends Cubit<ShopAppState> {

  ShopCubit() : super(ShopAppInitState());

  static ShopCubit get(context) => BlocProvider.of(context);
}
