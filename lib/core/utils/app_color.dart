import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color primary;
  final Color deep;
  final Color accent;
  final Color gold;
  final Color background;
  final Color textPrimary;
  final Color textSecondary;
  final Color primaryInverse;
  final Color error;
  final Color success;
  final Color white;
  final Color black;

  const AppColors({
    required this.primary,
    required this.deep,
    required this.accent,
    required this.gold,
    required this.background,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryInverse,
    required this.error,
    required this.success,
    required this.white,
    required this.black,
  });

  static const AppColors light = AppColors(
    primary: Color(0xFF2D6A4F),
    deep: Color(0xFF1B4332),
    accent: Color(0xFF40916C),
    gold: Color(0xFFC9A84C),
    background: Color(0xFFF5F0E8),
    textPrimary: Color(0xFF111111),
    textSecondary: Color(0xFF96886B),
    primaryInverse: Color(0xFFFFFFFF),
    error: Color(0xFFEF4444),
    success: Color(0xFF22C55E),
    white: Color(0xFFFFFFFF),
    black: Color(0xFF000000),
  );

  static const AppColors dark = AppColors(
    primary: Color(0xFF2D6A4F),
    deep: Color(0xFF1B4332),
    accent: Color(0xFF40916C),
    gold: Color(0xFFC9A84C),
    background: Color(0xFF121212),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFF8A8A8F),
    primaryInverse: Color(0xFF111111),
    error: Color(0xFFEF4444),
    success: Color(0xFF22C55E),
    white: Color(0xFFFFFFFF),
    black: Color(0xFF000000),
  );

  @override
  AppColors copyWith({
    Color? primary,
    Color? deep,
    Color? accent,
    Color? gold,
    Color? ivory,
    Color? background,
    Color? surface,
    Color? container,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? border,
    Color? primaryInverse,
    Color? error,
    Color? success,
    Color? white,
    Color? black,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      deep: deep ?? this.deep,
      accent: accent ?? this.accent,
      gold: gold ?? this.gold,
      background: background ?? this.background,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      primaryInverse: primaryInverse ?? this.primaryInverse,
      error: error ?? this.error,
      success: success ?? this.success,
      white: white ?? this.white,
      black: black ?? this.black,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      deep: Color.lerp(deep, other.deep, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      gold: Color.lerp(gold, other.gold, t)!,
      background: Color.lerp(background, other.background, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      primaryInverse: Color.lerp(primaryInverse, other.primaryInverse, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
    );
  }
}

extension AppColorsContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
