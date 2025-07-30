import 'package:aku_task/src/features/search/data/models/get_users/get_users_params.dart';
import 'package:aku_task/src/features/search/domain/entities/paginated_users/paginated_users_entity.dart';
import 'package:aku_task/src/features/search/domain/entities/user_entity/user_entity.dart';
import 'package:aku_task/src/features/search/domain/use_cases/get_users_by_query_use_case.dart';
import 'package:aku_task/src/features/search/domain/use_cases/get_users_use_case.dart';
import 'package:aku_task/src/features/shared/utils/bloc_transformers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_bloc.freezed.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required GetUsersUseCase getUsersUseCase,
    required GetUsersByQueryUseCase getUsersByQueryUseCase,
  }) : _getUsersUseCase = getUsersUseCase,
       _getUsersByQueryUseCase = getUsersByQueryUseCase,
       super(const SearchState.initial()) {
    on<GetUsers>(_onGetUsers);
    on<LoadMoreUsers>(
      _onLoadMoreUsers,
      // transformer: BlocTransformers.droppable(),
    );
    on<GetUsersByQuery>(
      _onGetUsersByQuery,
      transformer: BlocTransformers.debounceRestartable(
        const Duration(milliseconds: 400),
      ),
    );
  }

  final GetUsersUseCase _getUsersUseCase;
  final GetUsersByQueryUseCase _getUsersByQueryUseCase;
  int _skip = 0;
  final int _limit = 10;

  bool hasReachedEnd = false;

  Future<void> _onGetUsers(GetUsers event, Emitter<SearchState> emit) async {
    emit(const SearchState.loading());

    _skip = 0;
    hasReachedEnd = false;

    final result = await _getUsersUseCase(
      GetUsersParams(limit: _limit, skip: _skip),
    );

    result.fold(
      (failure) => emit(SearchState.error(message: failure.message)),
      (response) {
        _skip += _limit;
        hasReachedEnd = response.users.length < _limit;
        emit(SearchState.loaded(users: response));
      },
    );
  }

  Future<void> _onLoadMoreUsers(
    LoadMoreUsers event,
    Emitter<SearchState> emit,
  ) async {
    if (hasReachedEnd || state is! Loaded) return;
    if ((state as Loaded).isLoadingMore) return;

    final currentState = state as Loaded;
    emit(currentState.copyWith(isLoadingMore: true));

    final result = await _getUsersUseCase(
      GetUsersParams(limit: _limit, skip: _skip),
    );

    result.fold(
      (failure) => emit(currentState.copyWith(isLoadingMore: false)),
      (response) {
        final existingIds =
            currentState.users?.users.map((e) => e.id).toSet() ?? {};

        final newUsers = response.users
            .where((user) => !existingIds.contains(user.id))
            .toList();

        final combinedUsers = <UserEntity>[
          ...currentState.users?.users ?? [],
          ...newUsers,
        ];
        final updated = PaginatedUsersEntity(
          users: combinedUsers,
          total: response.total,
          skip: _skip,
        );
        _skip += _limit;
        hasReachedEnd =
            response.users.length < _limit ||
            combinedUsers.length >= response.total;
        emit(SearchState.loaded(users: updated));
      },
    );
  }

  Future<void> _onGetUsersByQuery(
    GetUsersByQuery event,
    Emitter<SearchState> emit,
  ) async {
    emit(
      SearchState.loading(
        users: state.users,
      ),
    );
    final result = await _getUsersByQueryUseCase(event.getUsersParams);
    result.fold(
      (failure) {
        emit(SearchState.error(users: state.users, message: failure.message));
      },
      (response) {
        emit(SearchState.loaded(users: state.users, searchedUsers: response));
      },
    );
  }
}
