import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchState> {

  SearchCubit() : super (SearchInitState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search({required String text}) {
    
    emit(SearchLoadingState());
    
    DioHelper.postData(url: SEARCH, token: TOKEN, data: {	"text": text}).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}