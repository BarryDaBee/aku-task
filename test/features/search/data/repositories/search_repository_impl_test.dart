import 'package:aku_task/src/core/error/error.dart';
import 'package:aku_task/src/core/utils/either.dart';
import 'package:aku_task/src/features/search/data/data_sources/search_data_source.dart';
import 'package:aku_task/src/features/search/data/models/get_users/get_users_params.dart';
import 'package:aku_task/src/features/search/data/models/get_users/get_users_response.dart';
import 'package:aku_task/src/features/search/data/repositories/search_repository_impl.dart';
import 'package:aku_task/src/features/search/domain/entities/paginated_users/paginated_users_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchDataSource extends Mock implements SearchDataSource {}

void main() {
  late SearchRepositoryImpl repository;
  late MockSearchDataSource mockDataSource;

  final params = GetUsersParams(limit: 1, skip: 0);

  setUpAll(() {
    registerFallbackValue(params);
  });

  setUp(() {
    mockDataSource = MockSearchDataSource();
    repository = SearchRepositoryImpl(dataSource: mockDataSource);
  });

  test(
    'returns Right<Failure, PaginatedUsersEntity> on getUsers success',
    () async {
      final userResponse = GetUsersResponse(
        users: [],
        total: 0,
        skip: 0,
        limit: 1,
      );

      when(
        () => mockDataSource.getUsers(params),
      ).thenAnswer((_) async => userResponse);

      final result = await repository.getUsers(params);

      expect(
        result,
        Right<Failure, PaginatedUsersEntity>(userResponse.toEntity()),
      );
      verify(() => mockDataSource.getUsers(params)).called(1);
    },
  );

  test(
    'returns Left<Failure, PaginatedUsersEntity> on getUsers failure',
    () async {
      final exception = DioException(
        requestOptions: RequestOptions(),
        message: 'Server error',
      );

      when(() => mockDataSource.getUsers(params)).thenThrow(exception);

      final result = await repository.getUsers(params);

      expect(
        result,
        isA<Left<Failure, PaginatedUsersEntity>>(),
      );
      verify(() => mockDataSource.getUsers(params)).called(1);
    },
  );
}
