import 'package:dio/dio.dart';

import '../end_points.dart';

class DioHelper {

  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: BaseUrl,
        receiveDataWhenStatusError: true,
      )
    );
  }

  static Future<Response> getData ({required String url, required Map<String, dynamic> query, String? lang, String? token}) async {

    dio!.options.headers = {
      'Content-Type' : 'application/json',
      'Authorization' : token ?? '',
      'lang' : lang
    };

    return await dio!.get(
      url, queryParameters: query,
    );
  }

  static Future<Response> postData ({required String url, required Map<String, dynamic> data, Map<String, dynamic>? query, String? lang, String? token}) async {

    dio!.options.headers = {
      'Content-Type' : 'application/json',
      'Authorization' : token ?? '',
      'lang' : lang
    };

    return await dio!.post(
        url,
        data: data,
        queryParameters: query,
    );
  }

  static Future<Response> putData ({required String url, Map<String, dynamic>? query,required Map<String, dynamic> data, String? lang,required String? token}) async {

    dio!.options.headers = {
      'Content-Type' : 'application/json',
      'Authorization' : token ?? '',
      'lang' : lang
    };

    return await dio!.put(
      url, queryParameters: query,
      data: data,
    );
  }

}