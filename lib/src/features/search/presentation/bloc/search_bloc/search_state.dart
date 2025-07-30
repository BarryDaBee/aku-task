part of 'search_bloc.dart';

@freezed
sealed class SearchState with _$SearchState {
  const factory SearchState.initial({
    PaginatedUsersEntity? users,
    PaginatedUsersEntity? searchedUsers,
  }) = Initial;
  const factory SearchState.loading({
    PaginatedUsersEntity? users,
    PaginatedUsersEntity? searchedUsers,
  }) = Loading;

  const factory SearchState.loaded({
    PaginatedUsersEntity? users,
    PaginatedUsersEntity? searchedUsers,
    @Default(false) bool isLoadingMore,
  }) = Loaded;

  const factory SearchState.error({
    required String message,
    PaginatedUsersEntity? users,
    PaginatedUsersEntity? searchedUsers,
  }) = Error;
}
