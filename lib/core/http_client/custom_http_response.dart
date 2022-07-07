class CustomHttpResponse {
  final dynamic data;
  final int? statusCode;
  final String? statusMessage;
  final bool timeout;
  final Map<String, dynamic>? header;

  CustomHttpResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
    this.timeout = false,
    this.header,
  });
}
