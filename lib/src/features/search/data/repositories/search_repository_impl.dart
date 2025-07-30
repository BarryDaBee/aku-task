import 'package:aku_task/src/core/error/error.dart';
import 'package:aku_task/src/core/utils/either.dart';
import 'package:aku_task/src/features/search/data/data_sources/search_data_source.dart';
import 'package:aku_task/src/features/search/data/models/get_users/get_users_params.dart';
import 'package:aku_task/src/features/search/data/models/get_users/get_users_response.dart';
import 'package:aku_task/src/features/search/domain/entities/paginated_users/paginated_users_entity.dart';
import 'package:aku_task/src/features/search/domain/repositories/search_repository.dart';
import 'package:dio/dio.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource dataSource;

  SearchRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, PaginatedUsersEntity>> getUsers(
    GetUsersParams params,
  ) async {
    try {
      final response = await dataSource.getUsers(params);
      return Right(response.toEntity());
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Unknown error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedUsersEntity>> getUsersByQuery(
    GetUsersParams params,
  ) async {
    try {
      final response = await dataSource.getUsersByQuery(params);
      return Right(response.toEntity());
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Unknown error'));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
