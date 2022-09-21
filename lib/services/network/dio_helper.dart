import 'dart:io';

import 'package:dio/dio.dart';

class DioHelper {
  static final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://10.0.2.2:7207/api'),
  );

  static Future<Response> getData({String path = "", String token = ""}) async {
    return await _dio.get(
      path,
      queryParameters: {
        "Authorization": "Bearer $token",
      },
    );
  }

  static Future<Response> postData(
      {String path = "", String token = "", Map<String, dynamic>? body}) async {
    Response response = await _dio.post(
      path,
      queryParameters: token.isNotEmpty
          ? {
              "Authorization": "Bearer $token",
            }
          : {},
      options: Options(contentType: "application/json"),
      data: body,
    );
    return response;
  }
}
