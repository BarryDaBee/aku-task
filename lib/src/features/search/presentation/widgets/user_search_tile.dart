import 'package:aku_task/src/features/search/domain/entities/user_entity/user_entity.dart';
import 'package:aku_task/src/features/shared/extensions/theme_context_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserSearchTile extends StatelessWidget {
  const UserSearchTile({
    required this.user,
    super.key,
  });
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
          color: colors?.grey.shade300 ?? Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Semantics(
            label: 'Profile picture of ${user.username}',
            image: true,
            child: CachedNetworkImage(
              width: 65,
              imageUrl: user.imageUrl,
              placeholder: (context, url) => const SizedBox(
                width: 65,
                height: 65,
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.fullName, style: context.textTheme.titleMedium),
                Text(user.email, style: context.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget roleBadge(String role) {
    final isAdmin = role.toLowerCase() == 'admin';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isAdmin ? Colors.red.shade100 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        role,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isAdmin ? Colors.red : Colors.black,
        ),
      ),
    );
  }
}
