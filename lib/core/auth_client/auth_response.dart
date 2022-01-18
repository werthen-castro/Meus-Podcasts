class AuthResponse {
  final dynamic data;
  final String? statusCode;
  final String? statusMessage;
  final bool sucess;

  AuthResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
    this.sucess = false,
  });
}
