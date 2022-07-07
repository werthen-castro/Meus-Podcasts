import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meus_podcats/core/erros/error_messages.dart';
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
        statusMessage: error.response?.statusMessage,
      );
    } on TimeoutException catch (_) {
      return CustomHttpResponse(
        statusMessage: ErrorMessages.errorTimeout,
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

  @override
  Future<CustomHttpResponse> post(String url, {Map? body}) async {
    Response response;

    try {
      response = await _dio.post(url, data: body);
    } on DioError catch (error) {
      return CustomHttpResponse(
          statusCode: error.response?.statusCode,
          statusMessage: error.response?.statusMessage);
    } on TimeoutException catch (_) {
      return CustomHttpResponse(
        statusMessage: ErrorMessages.errorTimeout,
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
        header: response.headers.map);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(err.message);
    print(err.response);
    handler.next(err);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers = {'Content-Type': 'application/json'};
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(response.realUri);
    print('----------------------');
    print(response.statusCode);
    print('----------------------');
    print(response.data);
    handler.next(response);
  }
}
