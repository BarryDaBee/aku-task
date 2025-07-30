import 'package:aku_task/src/features/search/data/models/get_users/get_users_params.dart';
import 'package:aku_task/src/features/search/data/models/get_users/get_users_response.dart';

abstract class SearchDataSource {
  Future<GetUsersResponse> getUsers(GetUsersParams params);
  Future<GetUsersResponse> getUsersByQuery(GetUsersParams params);
}
