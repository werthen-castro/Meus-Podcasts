import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? errorMessage;

  const Failure({this.errorMessage});
}

class ServerFailure extends Failure {
  final String? errorMessage;

  const ServerFailure({this.errorMessage});

  @override
  List<Object?> get props => [];
}

class NullParamsFailure extends Failure {
  @override
  List<Object?> get props => [];
}
