import 'package:aku_task/src/features/search/data/models/get_users/get_users_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'search_client.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com')
abstract class SearchClient {
  factory SearchClient(Dio dio, {String? baseUrl}) = _SearchClient;

  @GET('/users')
  Future<GetUsersResponse> getUsers({
    @Query('limit') required int limit,
    @Query('skip') required int skip,
  });

  @GET('/users/search')
  Future<GetUsersResponse> getUsersByQuery({
    @Query('q') required String query,
  });
}
