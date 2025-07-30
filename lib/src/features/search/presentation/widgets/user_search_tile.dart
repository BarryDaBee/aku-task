import 'package:aku_task/src/features/search/domain/entities/user_entity/user_entity.dart';
import 'package:aku_task/src/features/search/presentation/pages/profile_page.dart';
import 'package:animations/animations.dart';
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
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      closedElevation: 0,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      openBuilder: (_, __) => ProfilePage(user: user),
      closedBuilder: (_, openContainer) {
        return GestureDetector(
          onTap: openContainer,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
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
                        imageUrl: user.imageUrl ?? '',
                        width: 65,
                        height: 65,
                        placeholder: (_, __) => const SizedBox(
                          width: 65,
                          height: 65,
                          child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorWidget: (_, __, ___) => const Icon(
                          Icons.error_outline,
                          key: Key('image_error_icon'),
                        ),
                      ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName ?? 'Anon',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        user.email ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
