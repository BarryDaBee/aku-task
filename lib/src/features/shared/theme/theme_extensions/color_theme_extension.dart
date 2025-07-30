import 'package:flutter/material.dart';

class ColorThemeExtension extends ThemeExtension<ColorThemeExtension> {
  const ColorThemeExtension({
    required this.grey,
    required this.success,
    required this.error,
  });

  final MaterialColor grey;
  final MaterialColor success;
  final MaterialColor error;

  @override
  ThemeExtension<ColorThemeExtension> copyWith({
    MaterialColor? grey,
    MaterialColor? success,
    MaterialColor? error,
  }) => ColorThemeExtension(
    grey: grey ?? this.grey,
    success: success ?? this.success,
    error: error ?? this.error,
  );

  @override
  ThemeExtension<ColorThemeExtension> lerp(
    ThemeExtension<ColorThemeExtension>? other,
    double t,
  ) {
    if (other is! ColorThemeExtension) return this;
    return ColorThemeExtension(
      grey: grey.lerp(other.grey, t),
      success: success.lerp(other.success, t),
      error: error.lerp(other.error, t),
    );
  }
}

extension on MaterialColor {
  MaterialColor lerp(MaterialColor color, double t) {
    return MaterialColor(500, {
      50: Color.lerp(this[50], color[50], t) ?? this,
      for (int shade = 100; shade <= 900; shade += 100)
        shade: Color.lerp(this[shade], color[shade], t) ?? this,
    });
  }
}
