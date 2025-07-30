import 'package:aku_task/src/features/search/domain/entities/user_entity/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_users_entity.freezed.dart';

@freezed
abstract class PaginatedUsersEntity with _$PaginatedUsersEntity {
  const factory PaginatedUsersEntity({
    required List<UserEntity> users,
    required int total,
    required int skip,
  }) = _PaginatedUsersEntity;
}
