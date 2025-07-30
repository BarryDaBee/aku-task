import 'package:equatable/equatable.dart';

/// A type that holds either a [Left] or a [Right] value.
/// [Left] is used for failure, [Right] for success.
abstract class Either<L, R> extends Equatable {
  const Either();

  T fold<T>(T Function(L left) ifLeft, T Function(R right) ifRight) {
    if (this is Left<L, R>) {
      return ifLeft((this as Left<L, R>).value);
    } else if (this is Right<L, R>) {
      return ifRight((this as Right<L, R>).value);
    }
    throw Exception('Unknown Either type');
  }

  bool get isLeft => this is Left<L, R>;
  bool get isRight => this is Right<L, R>;

  L? leftOrNull() => this is Left<L, R> ? (this as Left<L, R>).value : null;
  R? rightOrNull() => this is Right<L, R> ? (this as Right<L, R>).value : null;
}

/// Holds a failure value.
class Left<L, R> extends Either<L, R> {
  const Left(this.value);
  final L value;

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'Left($value)';
}

/// Holds a success value.
class Right<L, R> extends Either<L, R> {
  const Right(this.value);
  final R value;

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'Right($value)';
}
