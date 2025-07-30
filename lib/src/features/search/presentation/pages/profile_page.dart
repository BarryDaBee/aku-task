import 'package:aku_task/src/features/search/domain/entities/user_entity/user_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({required this.user, super.key});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.fullName ?? 'Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: user.imageUrl ?? '',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const Icon(Icons.error_outline),
              ),
            ),
            const SizedBox(height: 16),
            Text(user.fullName ?? 'Anon', style: textTheme.headlineSmall),
            Text(user.email ?? '', style: textTheme.bodyLarge),
            const SizedBox(height: 24),
            _InfoRow(label: 'Username', value: user.username),
            _InfoRow(label: 'Phone', value: user.phone),
            _InfoRow(label: 'Company', value: user.company),
            _InfoRow(label: 'City', value: user.city),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, this.value});
  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value ?? 'N/A')),
        ],
      ),
    );
  }
}
