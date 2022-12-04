import 'dart:io';

import 'package:dio/dio.dart';

class DioHelper {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://10.0.2.2:7207/api',
      receiveDataWhenStatusError: true,
      connectTimeout: 15 * 1000,
      receiveTimeout: 15 * 1000,
    ),
  );

  static Future<Response> getData(
      {String path = "",
      String token = "",
      Map<String, dynamic> query = const {}}) async {
    var response = await _dio.get(
      path,
      queryParameters: query,
      options: Options(contentType: "application/json", headers: {
        "Authorization": "Bearer $token",
      }),
    );
    return response;
  }

  static Future<Response> postData(
      {String path = "",
      String token = "",
      Map<String, dynamic>? body,
      Map<String, dynamic> query = const {}}) async {
    Response response = await _dio.post(
      path,
      queryParameters: query,
      options: Options(contentType: "application/json", headers: {
        "Authorization": "Bearer $token",
      }),
      data: body,
    );
    return response;
  }
}
