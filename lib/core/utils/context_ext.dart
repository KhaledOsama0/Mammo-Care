import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

extension ContextExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  AppColors get colors =>
      Theme.of(this).extension<AppColors>() ??
      (Theme.of(this).brightness == Brightness.dark
          ? AppColors.dark
          : AppColors.light);

  AppTextStyles get textStyles {
    final ext = Theme.of(this).extension<AppTextStyles>();
    if (ext != null) return ext;
    final isAr = Directionality.of(this) == TextDirection.rtl;
    return AppTextStyles.build(
      textPrimary: colors.textPrimary,
      textSecondary: colors.textSecondary,
      textHint: colors.textHint,
      isArabic: isAr,
    );
  }

  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktopOrWeb => screenWidth >= 1024;
}