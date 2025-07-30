import 'package:aku_task/src/core/error/error.dart';
import 'package:aku_task/src/core/utils/either.dart';
import 'package:dio/dio.dart';

extension RepositoryExtension<T> on Future<T> {
  Future<Either<Failure, R>> makeRequest<R>({
    required R Function(T value) transform,
  }) async {
    try {
      final data = await this;
      return Right(transform(data));
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return const Left(
        ServerFailure(message: 'Something went wrong. Please try again'),
      );
    }
  }
}
