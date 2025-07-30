import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_users_params.freezed.dart';

@freezed
abstract class GetUsersParams with _$GetUsersParams {
  const factory GetUsersParams({
    required int limit,
    required int skip,
    String? query,
  }) = _GetUsersParams;
}
