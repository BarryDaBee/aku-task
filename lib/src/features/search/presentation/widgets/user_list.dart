import 'package:aku_task/src/features/search/domain/entities/paginated_users/paginated_users_entity.dart';
import 'package:aku_task/src/features/search/presentation/widgets/animated_user_search_tile.dart';
import 'package:aku_task/src/features/shared/extensions/localization_extension.dart';
import 'package:aku_task/src/features/shared/extensions/theme_context_extension.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  const UserList({
    required this.paginatedUsers,
    required this.onRefresh,
    required this.isLoading,
    super.key,
    this.scrollController,
  });
  final bool isLoading;
  final PaginatedUsersEntity? paginatedUsers;
  final ScrollController? scrollController;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    if (paginatedUsers == null || paginatedUsers!.users.isEmpty) {
      return Text(
        context.l10n?.usersNotFound ?? '',
        style: context.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16),
        controller: scrollController,
        itemCount: paginatedUsers!.users.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == paginatedUsers!.users.length) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = paginatedUsers!.users[index];
          return AnimatedUserSearchTile(
            user: user,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
      ),
    );
  }
}
