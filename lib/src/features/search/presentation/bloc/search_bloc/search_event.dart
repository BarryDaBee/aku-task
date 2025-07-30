part of 'search_bloc.dart';

@freezed
sealed class SearchEvent with _$SearchEvent {
  const factory SearchEvent.getUsers(GetUsersParams getUsersParams) = GetUsers;
  const factory SearchEvent.loadMoreUsers() = LoadMoreUsers;
  const factory SearchEvent.getUsersByQuery(GetUsersParams getUsersParams) =
      GetUsersByQuery;
}
