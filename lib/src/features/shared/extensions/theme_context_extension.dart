import 'package:aku_task/src/features/shared/theme/theme_extensions/color_theme_extension.dart';
import 'package:flutter/material.dart';

extension ThemeContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorThemeExtension? get colors => theme.extension<ColorThemeExtension>();

  TextTheme get textTheme => theme.textTheme;
}
