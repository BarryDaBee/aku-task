import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message, [this.payload]);
  final String message;
  final dynamic payload;
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({
    dynamic payload,
    String? message,
  }) : super(message ?? 'Something Went Wrong', payload);
}

// General failures
class CacheFailure extends Failure {
  const CacheFailure({
    String? message,
  }) : super(message ?? 'Something Went Wrong');
}
