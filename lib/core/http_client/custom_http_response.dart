class CustomHttpResponse {
  final dynamic data;
  final int? statusCode;
  final String? statusMessage;
  final bool timeout;

  CustomHttpResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
    this.timeout = false,
  });
}
