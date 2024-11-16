import 'package:dio/dio.dart';

class ShopDioHelper {
  static Dio? dio;

  static shopInit() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> shopGetData({
    required String url,
    Map<String, dynamic>? query,
    String? lang = 'en',
    String? token,
  }) async {
    dio?.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };

    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> shopPostData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang = 'en',
    String? token,
  }) async {
    dio?.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> shopPutData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang = 'en',
    String? token,
  }) async {
    dio?.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
