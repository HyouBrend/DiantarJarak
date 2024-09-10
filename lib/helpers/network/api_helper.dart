import 'package:dio/dio.dart';

abstract class ApiHelper {
  ApiHelper(Dio dio);

  Future<Response> get({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<Response> post({
    required String url,
    required dynamic body,
    Options? options,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> patch({
    required String url,
    required dynamic body,
    Options? options,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> downloadUri({
    required String url,
    required dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> getImage({
    required String url,
    Options? options,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });
}
