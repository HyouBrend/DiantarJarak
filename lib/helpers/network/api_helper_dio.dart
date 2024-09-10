import 'package:dio/dio.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class ApiHelperImpl implements ApiHelper {
  final Dio dio;

  ApiHelperImpl({required this.dio});

  @override
  Future<Response> get({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      print('Sending GET request to: $url');
      Response response = await dio.get(
        url,
        options: options,
        queryParameters: queryParameters,
      );
      print('Response received: ${response.data}');
      return response;
    } on DioError catch (e) {
      print('DioError: ${e.response?.statusCode} - ${e.message}');
      print('Response data: ${e.response?.data}');
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Response> post({
    required String url,
    required dynamic body,
    Options? options,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print('Sending POST request to: $url with body: $body');
      Response response = await dio.post(
        url,
        data: body,
        options: options,
        queryParameters: queryParameters,
      );
      print('Response received: ${response.data}');
      return response;
    } on DioError catch (e) {
      print('DioError: ${e.response?.statusCode} - ${e.message}');
      print('Response data: ${e.response?.data}');
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Response> patch({
    required String url,
    required dynamic body,
    Options? options,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print('Sending PATCH request to: $url with body: $body');
      Response response = await dio.patch(
        url,
        data: body,
        options: options,
        queryParameters: queryParameters,
      );
      print('Response received: ${response.data}');
      return response;
    } on DioError catch (e) {
      print('DioError: ${e.response?.statusCode} - ${e.message}');
      print('Response data: ${e.response?.data}');
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Response> downloadUri({
    required String url,
    required dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print('Sending DOWNLOAD request to: $url with body: $body');
      final Response response = await dio.downloadUri(
        Uri.parse(url),
        body,
      );
      print('Response received: ${response.data}');
      return response;
    } on DioError catch (e) {
      print('DioError: ${e.response?.statusCode} - ${e.message}');
      print('Response data: ${e.response?.data}');
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Response> getImage({
    required String url,
    Options? options,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print('Sending GET IMAGE request to: $url');
      final Response response = await dio.get(
        url,
        options: options,
      );
      print('Response received: ${response.data}');
      return response;
    } on DioError catch (e) {
      print('DioError: ${e.response?.statusCode} - ${e.message}');
      print('Response data: ${e.response?.data}');
      rethrow;
    } on Exception {
      rethrow;
    }
  }
}
