// user_search_tile_test.dart

import 'package:aku_task/src/features/search/domain/entities/user_entity/user_entity.dart';
import 'package:aku_task/src/features/search/presentation/widgets/user_search_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserSearchTile', () {
    testWidgets('displays fullName and email', (WidgetTester tester) async {
      const user = UserEntity(
        id: 1,
        fullName: 'Jane Doe',
        email: 'jane@example.com',
        imageUrl: 'https://this.should.fail/image.png',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserSearchTile(user: user),
          ),
        ),
      );

      expect(find.text('Jane Doe'), findsOneWidget);
      expect(find.text('jane@example.com'), findsOneWidget);
      expect(find.byKey(const Key('user_profile_image')), findsOneWidget);
    });

    testWidgets(
      'shows error icon when imageOverride is used (simulate error)',
      (WidgetTester tester) async {
        const user = UserEntity(
          id: 2,
          fullName: 'Broken Image',
          email: 'fail@example.com',
          imageUrl: 'https://broken.url/image.png',
        );

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: UserSearchTile(
                user: user,
                imageOverride: Icon(Icons.error, key: Key('image_error_icon')),
              ),
            ),
          ),
        );

        expect(find.byKey(const Key('image_error_icon')), findsOneWidget);
      },
    );
  });
}
