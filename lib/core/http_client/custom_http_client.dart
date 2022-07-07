import 'custom_http_response.dart';

abstract class CustomHttpClient {
  Future<CustomHttpResponse> get(String url);
  Future<CustomHttpResponse> post(String url, {Map? body});
}
