import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'custom_http_client.dart';
import 'custom_http_response.dart';

class CustomHttpClientImpl implements CustomHttpClient {
  final Dio _dio = Dio();
  final Map<String, dynamic>? header;

  CustomHttpClientImpl({this.header}) {
    _dio.options.headers = header;
  }

  @override
  Future<CustomHttpResponse> get(String url) async {
    Response response;

    try {
      response = await _dio.get(url);
    } on DioError catch (error) {
      return CustomHttpResponse(
          statusCode: error.response?.statusCode,
          statusMessage: error.response?.statusMessage);
    } on TimeoutException catch (_) {
      return CustomHttpResponse(
        timeout: true,
      );
    } on SocketException catch (exception) {
      return CustomHttpResponse(
        statusMessage: exception.message,
      );
    }

    return CustomHttpResponse(
      data: response.data,
      statusCode: response.statusCode,
    );
  }
}
