import 'package:aku_task/src/features/search/data/client/search_client.dart';
import 'package:aku_task/src/features/search/data/data_sources/search_data_source.dart';
import 'package:aku_task/src/features/search/data/models/get_users/get_users_params.dart';
import 'package:aku_task/src/features/search/data/models/get_users/get_users_response.dart';

/// Search DataSource uses [SearchClient] to make requests
///
class SearchDataSourceImpl implements SearchDataSource {
  const SearchDataSourceImpl({required SearchClient client}) : _client = client;

  final SearchClient _client;

  @override
  Future<GetUsersResponse> getUsers(GetUsersParams params) =>
      _client.getUsers(limit: params.limit, skip: params.skip);

  @override
  Future<GetUsersResponse> getUsersByQuery(GetUsersParams params) =>
      _client.getUsersByQuery(
        query: params.query ?? '',
      );
}
