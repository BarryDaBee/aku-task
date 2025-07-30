import 'package:aku_task/src/di/locator.dart';
import 'package:aku_task/src/features/search/data/models/get_users/get_users_params.dart';
import 'package:aku_task/src/features/search/domain/use_cases/get_users_by_query_use_case.dart';
import 'package:aku_task/src/features/search/domain/use_cases/get_users_use_case.dart';
import 'package:aku_task/src/features/search/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:aku_task/src/features/search/presentation/widgets/user_list.dart';
import 'package:aku_task/src/features/shared/extensions/localization_extension.dart';
import 'package:aku_task/src/features/shared/extensions/theme_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final _searchBloc = SearchBloc(
    getUsersByQueryUseCase: locator<GetUsersByQueryUseCase>(),
    getUsersUseCase: locator<GetUsersUseCase>(),
  )..add(const SearchEvent.getUsers(GetUsersParams(limit: 10, skip: 0)));

  void _onScroll(BuildContext context) {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_scrollController.position.outOfRange) {
      _searchBloc.add(const SearchEvent.loadMoreUsers());
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() => _onScroll(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: context.l10n?.searchUser,
                ),
                onChanged: (value) {
                  if (value.isEmpty) return;
                  _searchBloc.add(
                    SearchEvent.getUsersByQuery(
                      GetUsersParams(limit: 10, skip: 0, query: value),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  bloc: _searchBloc,
                  builder: (context, state) {
                    return switch (state) {
                      Initial() => const SizedBox.shrink(),
                      Loading() => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      Error(:final message) => Center(
                        child: Text('Error: $message'),
                      ),
                      Loaded(
                        :final users,
                        :final isLoadingMore,
                        :final searchedUsers,
                      ) =>
                        Column(
                          children: [
                            Expanded(
                              child: ValueListenableBuilder(
                                valueListenable: _searchController,
                                builder: (context, value, child) {
                                  final isSearching = value.text.isNotEmpty;
                                  return UserList(
                                    isLoading: isLoadingMore,
                                    paginatedUsers: isSearching
                                        ? searchedUsers
                                        : users,
                                    scrollController: _scrollController,
                                    onRefresh: () async {
                                      _searchBloc.add(
                                        const SearchEvent.getUsers(
                                          GetUsersParams(limit: 10, skip: 0),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            if (_searchBloc.hasReachedEnd)
                              TextButton(
                                onPressed: () {
                                  _scrollController.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.decelerate,
                                  );
                                },
                                child: Text(
                                  "That's everyone!",
                                  style: context.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _searchBloc.close();
    super.dispose();
  }
}
