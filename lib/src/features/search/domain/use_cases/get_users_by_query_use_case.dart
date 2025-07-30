import 'package:aku_task/src/core/error/error.dart';
import 'package:aku_task/src/core/utils/either.dart';
import 'package:aku_task/src/core/utils/use_case.dart';
import 'package:aku_task/src/features/search/data/models/get_users/get_users_params.dart';
import 'package:aku_task/src/features/search/domain/entities/paginated_users/paginated_users_entity.dart';
import 'package:aku_task/src/features/search/domain/repositories/search_repository.dart';

class GetUsersByQueryUseCase
    with UseCase<PaginatedUsersEntity, GetUsersParams> {
  const GetUsersByQueryUseCase(this.repository);

  final SearchRepository repository;

  @override
  Future<Either<Failure, PaginatedUsersEntity>> call(GetUsersParams params) {
    return repository.getUsersByQuery(params);
  }
}
