import 'package:aku_task/src/core/error/error.dart';
import 'package:aku_task/src/core/extensions/repository_extension.dart';
import 'package:aku_task/src/core/utils/either.dart';
import 'package:aku_task/src/features/search/data/data_sources/search_data_source.dart';
import 'package:aku_task/src/features/search/data/models/get_users/get_users_params.dart';
import 'package:aku_task/src/features/search/data/models/get_users/get_users_response.dart';
import 'package:aku_task/src/features/search/domain/entities/paginated_users/paginated_users_entity.dart';
import 'package:aku_task/src/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  const SearchRepositoryImpl({required SearchDataSource dataSource})
    : _dataSource = dataSource;
  final SearchDataSource _dataSource;

  @override
  Future<Either<Failure, PaginatedUsersEntity>> getUsers(
    GetUsersParams params,
  ) async => _dataSource
      .getUsers(params)
      .makeRequest(transform: (res) => res.toEntity());

  @override
  Future<Either<Failure, PaginatedUsersEntity>> getUsersByQuery(
    GetUsersParams params,
  ) async => _dataSource
      .getUsersByQuery(params)
      .makeRequest(transform: (res) => res.toEntity());
}
