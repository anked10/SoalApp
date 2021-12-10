import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NoConnectionFailure extends Failure {}

class ApiError extends Failure {
   ApiError({required this.code,required this.message});

  final String code;
  final String message;

  @override
  List<Object> get props => [code,message];
}
