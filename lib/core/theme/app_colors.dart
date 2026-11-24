import 'package:flutter/material.dart';

/// Mammo Care Design System — Color Tokens
/// Based on Figma design (Primary: #244B5E | Pink: #DFA6B9)
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.primaryDark,
    required this.primaryLight,
    required this.secondary,
    required this.secondaryLight,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.onPrimary,
    required this.onSecondary,
    required this.onBackground,
    required this.onSurface,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
    required this.textOnDark,
    required this.border,
    required this.divider,
    required this.inputBackground,
    required this.inputBorder,
    required this.error,
    required this.success,
    required this.warning,
    required this.cardBackground,
    required this.shadow,
    required this.navBackground,
    required this.navActive,
    required this.navInactive,
    required this.badgePink,
    required this.badgeLowConcern,
    required this.badgeLowConcernText,
    required this.badgeReviewed,
    required this.badgeReviewedText,
    required this.badgeNormal,
    required this.badgeNormalText,
    required this.badgeNeedAction,
    required this.badgeNeedActionText,
    required this.shimmerBase,
    required this.shimmerHighlight,
  });

  final Color primary;
  final Color primaryDark;
  final Color primaryLight;
  final Color secondary;
  final Color secondaryLight;
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color onPrimary;
  final Color onSecondary;
  final Color onBackground;
  final Color onSurface;
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;
  final Color textOnDark;
  final Color border;
  final Color divider;
  final Color inputBackground;
  final Color inputBorder;
  final Color error;
  final Color success;
  final Color warning;
  final Color cardBackground;
  final Color shadow;
  final Color navBackground;
  final Color navActive;
  final Color navInactive;
  final Color badgePink;
  final Color badgeLowConcern;
  final Color badgeLowConcernText;
  final Color badgeReviewed;
  final Color badgeReviewedText;
  final Color badgeNormal;
  final Color badgeNormalText;
  final Color badgeNeedAction;
  final Color badgeNeedActionText;
  final Color shimmerBase;
  final Color shimmerHighlight;

  // ─── Light Theme ───────────────────────────────────────────────────────────
  static const AppColors light = AppColors(
    primary: Color(0xFF244B5E),
    primaryDark: Color(0xFF183B4A),
    primaryLight: Color(0xFF3D7A96),
    secondary: Color(0xFFDFA6B9),
    secondaryLight: Color(0xFFF5D9E4),
    background: Color(0xFFF5F9FA),
    surface: Color(0xFFFFFFFF),
    surfaceVariant: Color(0xFFEDF4F6),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF183B4A),
    onBackground: Color(0xFF183B4A),
    onSurface: Color(0xFF183B4A),
    textPrimary: Color(0xFF183B4A),
    textSecondary: Color(0xFF67818A),
    textHint: Color(0xFF9BB8C1),
    textOnDark: Color(0xFFD5E9EF),
    border: Color(0xFFDCE8EB),
    divider: Color(0xFFE8F0F2),
    inputBackground: Color(0xFFF5F9FA),
    inputBorder: Color(0xFFDCE8EB),
    error: Color(0xFFE05C6E),
    success: Color(0xFF3ECFA0),
    warning: Color(0xFFF5A623),
    cardBackground: Color(0xFFFFFFFF),
    shadow: Color(0x1A244B5E),
    navBackground: Color(0xFFFFFFFF),
    navActive: Color(0xFF244B5E),
    navInactive: Color(0xFF9BB8C1),
    badgePink: Color(0xFFDFA6B9),
    badgeLowConcern: Color(0xFFE8F5F0),
    badgeLowConcernText: Color(0xFF2E7D59),
    badgeReviewed: Color(0xFFEDF4F6),
    badgeReviewedText: Color(0xFF497981),
    badgeNormal: Color(0xFFEBF7F3),
    badgeNormalText: Color(0xFF2E7D59),
    badgeNeedAction: Color(0xFFFEEEF0),
    badgeNeedActionText: Color(0xFFE05C6E),
    shimmerBase: Color(0xFFE8F0F2),
    shimmerHighlight: Color(0xFFF5F9FA),
  );

  // ─── Dark Theme ────────────────────────────────────────────────────────────
  static const AppColors dark = AppColors(
    primary: Color(0xFF4A9CB8),
    primaryDark: Color(0xFF244B5E),
    primaryLight: Color(0xFF6DB8D0),
    secondary: Color(0xFFDFA6B9),
    secondaryLight: Color(0xFF8C4A60),
    background: Color(0xFF0D1E27),
    surface: Color(0xFF152633),
    surfaceVariant: Color(0xFF1D3344),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    onBackground: Color(0xFFE2EEF2),
    onSurface: Color(0xFFE2EEF2),
    textPrimary: Color(0xFFE2EEF2),
    textSecondary: Color(0xFF8BAEBB),
    textHint: Color(0xFF4D7080),
    textOnDark: Color(0xFFD5E9EF),
    border: Color(0xFF2A4555),
    divider: Color(0xFF1F3545),
    inputBackground: Color(0xFF1D3344),
    inputBorder: Color(0xFF2A4555),
    error: Color(0xFFFF6B7A),
    success: Color(0xFF4EDFAF),
    warning: Color(0xFFFFB84D),
    cardBackground: Color(0xFF152633),
    shadow: Color(0x33000000),
    navBackground: Color(0xFF152633),
    navActive: Color(0xFF4A9CB8),
    navInactive: Color(0xFF4D7080),
    badgePink: Color(0xFFDFA6B9),
    badgeLowConcern: Color(0xFF1A3D30),
    badgeLowConcernText: Color(0xFF4EDFAF),
    badgeReviewed: Color(0xFF1D3344),
    badgeReviewedText: Color(0xFF6DB8D0),
    badgeNormal: Color(0xFF1A3D30),
    badgeNormalText: Color(0xFF4EDFAF),
    badgeNeedAction: Color(0xFF3D1A20),
    badgeNeedActionText: Color(0xFFFF6B7A),
    shimmerBase: Color(0xFF1D3344),
    shimmerHighlight: Color(0xFF254557),
  );

  static AppColors of(BuildContext context) =>
      Theme.of(context).extension<AppColors>()!;

  @override
  AppColors copyWith({
    Color? primary, Color? primaryDark, Color? primaryLight,
    Color? secondary, Color? secondaryLight,
    Color? background, Color? surface, Color? surfaceVariant,
    Color? onPrimary, Color? onSecondary, Color? onBackground, Color? onSurface,
    Color? textPrimary, Color? textSecondary, Color? textHint, Color? textOnDark,
    Color? border, Color? divider, Color? inputBackground, Color? inputBorder,
    Color? error, Color? success, Color? warning,
    Color? cardBackground, Color? shadow,
    Color? navBackground, Color? navActive, Color? navInactive,
    Color? badgePink,
    Color? badgeLowConcern, Color? badgeLowConcernText,
    Color? badgeReviewed, Color? badgeReviewedText,
    Color? badgeNormal, Color? badgeNormalText,
    Color? badgeNeedAction, Color? badgeNeedActionText,
    Color? shimmerBase, Color? shimmerHighlight,
  }) => AppColors(
    primary: primary ?? this.primary,
    primaryDark: primaryDark ?? this.primaryDark,
    primaryLight: primaryLight ?? this.primaryLight,
    secondary: secondary ?? this.secondary,
    secondaryLight: secondaryLight ?? this.secondaryLight,
    background: background ?? this.background,
    surface: surface ?? this.surface,
    surfaceVariant: surfaceVariant ?? this.surfaceVariant,
    onPrimary: onPrimary ?? this.onPrimary,
    onSecondary: onSecondary ?? this.onSecondary,
    onBackground: onBackground ?? this.onBackground,
    onSurface: onSurface ?? this.onSurface,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    textHint: textHint ?? this.textHint,
    textOnDark: textOnDark ?? this.textOnDark,
    border: border ?? this.border,
    divider: divider ?? this.divider,
    inputBackground: inputBackground ?? this.inputBackground,
    inputBorder: inputBorder ?? this.inputBorder,
    error: error ?? this.error,
    success: success ?? this.success,
    warning: warning ?? this.warning,
    cardBackground: cardBackground ?? this.cardBackground,
    shadow: shadow ?? this.shadow,
    navBackground: navBackground ?? this.navBackground,
    navActive: navActive ?? this.navActive,
    navInactive: navInactive ?? this.navInactive,
    badgePink: badgePink ?? this.badgePink,
    badgeLowConcern: badgeLowConcern ?? this.badgeLowConcern,
    badgeLowConcernText: badgeLowConcernText ?? this.badgeLowConcernText,
    badgeReviewed: badgeReviewed ?? this.badgeReviewed,
    badgeReviewedText: badgeReviewedText ?? this.badgeReviewedText,
    badgeNormal: badgeNormal ?? this.badgeNormal,
    badgeNormalText: badgeNormalText ?? this.badgeNormalText,
    badgeNeedAction: badgeNeedAction ?? this.badgeNeedAction,
    badgeNeedActionText: badgeNeedActionText ?? this.badgeNeedActionText,
    shimmerBase: shimmerBase ?? this.shimmerBase,
    shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
  );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      secondaryLight: Color.lerp(secondaryLight, other.secondaryLight, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      textOnDark: Color.lerp(textOnDark, other.textOnDark, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      inputBackground: Color.lerp(inputBackground, other.inputBackground, t)!,
      inputBorder: Color.lerp(inputBorder, other.inputBorder, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      navBackground: Color.lerp(navBackground, other.navBackground, t)!,
      navActive: Color.lerp(navActive, other.navActive, t)!,
      navInactive: Color.lerp(navInactive, other.navInactive, t)!,
      badgePink: Color.lerp(badgePink, other.badgePink, t)!,
      badgeLowConcern: Color.lerp(badgeLowConcern, other.badgeLowConcern, t)!,
      badgeLowConcernText: Color.lerp(badgeLowConcernText, other.badgeLowConcernText, t)!,
      badgeReviewed: Color.lerp(badgeReviewed, other.badgeReviewed, t)!,
      badgeReviewedText: Color.lerp(badgeReviewedText, other.badgeReviewedText, t)!,
      badgeNormal: Color.lerp(badgeNormal, other.badgeNormal, t)!,
      badgeNormalText: Color.lerp(badgeNormalText, other.badgeNormalText, t)!,
      badgeNeedAction: Color.lerp(badgeNeedAction, other.badgeNeedAction, t)!,
      badgeNeedActionText: Color.lerp(badgeNeedActionText, other.badgeNeedActionText, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(shimmerHighlight, other.shimmerHighlight, t)!,
    );
  }
}
