// user_search_tile.dart

import 'package:aku_task/src/features/search/domain/entities/user_entity/user_entity.dart';
import 'package:aku_task/src/features/shared/extensions/theme_context_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserSearchTile extends StatelessWidget {
  const UserSearchTile({
    required this.user,
    this.imageOverride,
    super.key,
  });

  final UserEntity user;
  final Widget? imageOverride;

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
            label: 'Profile picture of ${user.fullName ?? "Unknown"}',
            image: true,
            child:
                imageOverride ??
                CachedNetworkImage(
                  key: const Key('user_profile_image'),
                  width: 65,
                  height: 65,
                  imageUrl: user.imageUrl ?? '',
                  placeholder: (context, url) => const SizedBox(
                    width: 65,
                    height: 65,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, key: Key('image_error_icon')),
                ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName ?? 'Anon',
                  key: const Key('user_name'),
                  style: context.textTheme.titleMedium,
                ),
                Text(
                  user.email ?? '',
                  key: const Key('user_email'),
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
