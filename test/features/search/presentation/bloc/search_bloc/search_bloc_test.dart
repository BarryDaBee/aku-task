import 'package:aku_task/src/core/utils/either.dart';
import 'package:aku_task/src/features/search/data/models/get_users/get_users_params.dart';
import 'package:aku_task/src/features/search/domain/entities/paginated_users/paginated_users_entity.dart';
import 'package:aku_task/src/features/search/domain/entities/user_entity/user_entity.dart';
import 'package:aku_task/src/features/search/domain/use_cases/get_users_by_query_use_case.dart';
import 'package:aku_task/src/features/search/domain/use_cases/get_users_use_case.dart';
import 'package:aku_task/src/features/search/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsersUseCase extends Mock implements GetUsersUseCase {}

class MockGetUsersByQueryUseCase extends Mock
    implements GetUsersByQueryUseCase {}

class FakeGetUsersParams extends Fake implements GetUsersParams {}

void main() {
  late GetUsersUseCase getUsersUseCase;
  late GetUsersByQueryUseCase getUsersByQueryUseCase;
  late SearchBloc bloc;

  setUpAll(() {
    registerFallbackValue(FakeGetUsersParams());
  });
  setUp(() {
    getUsersUseCase = MockGetUsersUseCase();
    getUsersByQueryUseCase = MockGetUsersByQueryUseCase();
    bloc = SearchBloc(
      getUsersUseCase: getUsersUseCase,
      getUsersByQueryUseCase: getUsersByQueryUseCase,
    );
  });

  final users = [
    const UserEntity(id: 1, fullName: "John Doe"),
  ];

  final paginatedUsers = PaginatedUsersEntity(users: users, total: 1, skip: 0);

  blocTest<SearchBloc, SearchState>(
    'emits [loading, loaded] when GetUsers succeeds',
    build: () {
      when(
        () => getUsersUseCase(any()),
      ).thenAnswer((_) async => Right(paginatedUsers));
      return bloc;
    },
    act: (bloc) => bloc.add(const GetUsers(GetUsersParams())),
    expect: () => [
      const SearchState.loading(),
      SearchState.loaded(users: paginatedUsers),
    ],
    verify: (_) {
      verify(() => getUsersUseCase(any())).called(1);
    },
  );
}
