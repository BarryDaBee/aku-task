import 'package:aku_task/src/core/error/error.dart';
import 'package:aku_task/src/core/utils/either.dart';
import 'package:equatable/equatable.dart';

/// Base contract for a use case.
///
/// Takes [Params] as input and returns either a [Failure] or [DataType].
mixin UseCase<DataType, Params> {
  Future<Either<Failure, DataType>> call(Params params);
}

/// Used when a use case doesn't require any input.
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
