import 'package:aku_task/l10n/app_localizations.dart';
import 'package:aku_task/src/features/search/presentation/pages/search_page.dart';
import 'package:aku_task/src/features/shared/theme/app_colors.dart';
import 'package:aku_task/src/features/shared/theme/theme_extensions/color_theme_extension.dart';
import 'package:aku_task/src/features/shared/widgets/unfocus.dart';
import 'package:flutter/material.dart';

class AkuTaskApp extends StatelessWidget {
  const AkuTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Unfocus(
      child: MaterialApp(
        title: 'Aku Task',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: const [
          Locale('en'), // English
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: AppColors.grey.shade300,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide.none,
            ),
          ),
          extensions: const [
            ColorThemeExtension(
              grey: AppColors.grey,
              success: AppColors.success,
              error: AppColors.error,
            ),
          ],
        ),
        home: const SearchPage(),
      ),
    );
  }
}
