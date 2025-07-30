import 'package:aku_task/src/core/error/error.dart';
import 'package:aku_task/src/core/utils/either.dart';
import 'package:aku_task/src/features/search/data/data_sources/search_data_source.dart';
import 'package:aku_task/src/features/search/data/models/get_users/get_users_params.dart';
import 'package:aku_task/src/features/search/data/models/get_users/get_users_response.dart';
import 'package:aku_task/src/features/search/data/repositories/search_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchDataSource extends Mock implements SearchDataSource {}

void main() {
  late SearchRepositoryImpl repository;
  late MockSearchDataSource mockDataSource;

  final params = GetUsersParams(limit: 10, skip: 0);

  final user = User(
    id: 1,
    firstName: 'John',
    lastName: 'Doe',
    maidenName: 'Smith',
    age: 30,
    gender: 'male',
    email: 'john.doe@example.com',
    phone: '1234567890',
    username: 'johndoe',
    password: 'password123',
    birthDate: '1990-01-01',
    image: 'image_url',
    bloodGroup: 'A+',
    height: 180,
    weight: 75,
    eyeColor: 'blue',
    hair: Hair(color: 'brown', type: 'straight'),
    ip: '192.168.1.1',
    address: Address(
      address: '123 Street',
      city: 'Lagos',
      state: 'Lagos',
      stateCode: 'LA',
      postalCode: '100001',
      coordinates: Coordinates(lat: 6.5244, lng: 3.3792),
      country: 'Nigeria',
    ),
    macAddress: '00:1B:44:11:3A:B7',
    university: 'University of Lagos',
    bank: Bank(
      cardExpire: '12/25',
      cardNumber: '1234567890123456',
      cardType: 'Visa',
      currency: 'NGN',
      iban: 'NG1234567890',
    ),
    company: Company(
      department: 'Engineering',
      name: 'Tech Corp',
      title: 'Software Engineer',
      address: Address(
        address: '123 Street',
        city: 'Lagos',
        state: 'Lagos',
        stateCode: 'LA',
        postalCode: '100001',
        coordinates: Coordinates(lat: 6.5244, lng: 3.3792),
        country: 'Nigeria',
      ),
    ),
    ein: '123456789',
    ssn: '123-45-6789',
    userAgent: 'agent',
    crypto: Crypto(coin: 'BTC', wallet: 'wallet123', network: 'Bitcoin'),
    role: 'admin',
  );

  final response = GetUsersResponse(
    users: [user],
    total: 1,
    skip: 0,
    limit: 10,
  );

  final expectedEntity = response.toEntity();

  setUp(() {
    mockDataSource = MockSearchDataSource();
    repository = SearchRepositoryImpl(dataSource: mockDataSource);
  });

  group('SearchRepositoryImpl', () {
    test('returns Right(PaginatedUsersEntity) on getUsers success', () async {
      when(
        () => mockDataSource.getUsers(params),
      ).thenAnswer((_) async => Right(response));

      final result = await repository.getUsers(params);

      expect(result, Right(expectedEntity));
      verify(() => mockDataSource.getUsers(params)).called(1);
    });

    test('returns Left(Failure) on getUsers failure', () async {
      final failure = ServerFailure(message: 'Server error');

      when(
        () => mockDataSource.getUsers(params),
      ).thenAnswer((_) async => Left(failure));

      final result = await repository.getUsers(params);

      expect(result, Left(failure));
      verify(() => mockDataSource.getUsers(params)).called(1);
    });

    test(
      'returns Right(PaginatedUsersEntity) on getUsersByQuery success',
      () async {
        when(
          () => mockDataSource.getUsersByQuery(params),
        ).thenAnswer((_) async => Right(response));

        final result = await repository.getUsersByQuery(params);

        expect(result, Right(expectedEntity));
        verify(() => mockDataSource.getUsersByQuery(params)).called(1);
      },
    );

    test('returns Left(Failure) on getUsersByQuery failure', () async {
      final failure = ServerFailure(message: 'Network failed');

      when(
        () => mockDataSource.getUsersByQuery(params),
      ).thenAnswer((_) async => Left(failure));

      final result = await repository.getUsersByQuery(params);

      expect(result, Left(failure));
      verify(() => mockDataSource.getUsersByQuery(params)).called(1);
    });
  });
}
