import 'package:equatable/equatable.dart';

class CustomServerException extends Equatable implements Exception {
  final String? messageError;
  final bool timeout;

  const CustomServerException({
    this.messageError,
    this.timeout = false,
  });

  @override
  List<Object?> get props => [];
}
