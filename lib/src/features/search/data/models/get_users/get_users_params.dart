import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_users_params.freezed.dart';

@freezed
abstract class GetUsersParams with _$GetUsersParams {
  const factory GetUsersParams({
    @Default(10) int limit,
    @Default(0) int skip,
    String? query,
  }) = _GetUsersParams;
}
