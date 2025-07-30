import 'package:aku_task/src/core/error/error.dart';
import 'package:aku_task/src/core/utils/either.dart';
import 'package:aku_task/src/features/search/data/models/get_users/get_users_params.dart';
import 'package:aku_task/src/features/search/domain/entities/paginated_users/paginated_users_entity.dart';
import 'package:aku_task/src/features/search/domain/entities/user_entity/user_entity.dart';
import 'package:aku_task/src/features/search/domain/repositories/search_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchRepository extends Mock implements SearchRepository {}

void main() {
  late MockSearchRepository repository;

  setUpAll(() {
    registerFallbackValue(const GetUsersParams(limit: 0, skip: 0));
  });

  setUp(() {
    repository = MockSearchRepository();
  });

  const tParams = GetUsersParams(limit: 10, skip: 0, query: 'john');

  const tUser = UserEntity(
    id: 1,
    fullName: 'John Doe',
    age: 30,
    gender: 'male',
    email: 'john@example.com',
    phone: '1234567890',
    username: 'johndoe',
    birthDate: '1994-01-01',
    imageUrl: 'https://example.com/avatar.jpg',
    bloodGroup: 'O+',
    height: 180,
    weight: 75,
    eyeColor: 'brown',
    hairColor: 'black',
    hairType: 'curly',
    city: 'Lagos',
    state: 'Lagos',
    country: 'Nigeria',
    university: 'Unilag',
    company: 'Tech Co',
    role: 'Developer',
    title: 'Software Engineer',
  );

  const tPaginatedUsers = PaginatedUsersEntity(
    users: [tUser],
    total: 1,
    skip: 0,
  );

  group('SearchRepository', () {
    test('getUsers should return paginated users on success', () async {
      when(() => repository.getUsers(tParams)).thenAnswer(
        (_) async => const Right(tPaginatedUsers),
      );

      final result = await repository.getUsers(tParams);

      expect(
        result,
        const Right<Failure, PaginatedUsersEntity>(tPaginatedUsers),
      );
      verify(() => repository.getUsers(tParams)).called(1);
    });

    test('getUsersByQuery should return paginated users on success', () async {
      when(() => repository.getUsersByQuery(tParams)).thenAnswer(
        (_) async => const Right(tPaginatedUsers),
      );

      final result = await repository.getUsersByQuery(tParams);

      expect(
        result,
        const Right<Failure, PaginatedUsersEntity>(tPaginatedUsers),
      );
      verify(() => repository.getUsersByQuery(tParams)).called(1);
    });

    test('getUsers should return ServerFailure on error', () async {
      const failure = ServerFailure(message: 'Server error');

      when(() => repository.getUsers(tParams)).thenAnswer(
        (_) async => const Left(failure),
      );

      final result = await repository.getUsers(tParams);

      expect(result, const Left<Failure, PaginatedUsersEntity>(failure));
      verify(() => repository.getUsers(tParams)).called(1);
    });

    test('getUsersByQuery should return ServerFailure on error', () async {
      const failure = ServerFailure(message: 'Server error');

      when(() => repository.getUsersByQuery(tParams)).thenAnswer(
        (_) async => const Left(failure),
      );

      final result = await repository.getUsersByQuery(tParams);

      expect(result, const Left<Failure, PaginatedUsersEntity>(failure));
      verify(() => repository.getUsersByQuery(tParams)).called(1);
    });
  });
}
