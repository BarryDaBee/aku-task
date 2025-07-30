import 'package:aku_task/src/core/error/error.dart';
import 'package:aku_task/src/core/utils/either.dart';
import 'package:aku_task/src/features/search/data/models/get_users/get_users_params.dart';
import 'package:aku_task/src/features/search/domain/entities/paginated_users/paginated_users_entity.dart';

abstract interface class SearchRepository {
  Future<Either<Failure, PaginatedUsersEntity>> getUsers(GetUsersParams params);
  Future<Either<Failure, PaginatedUsersEntity>> getUsersByQuery(
    GetUsersParams params,
  );
}
