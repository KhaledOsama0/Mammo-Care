import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

abstract class AppTheme {
  static ThemeData buildTheme({
    required AppColors colors,
    required bool isArabic,
    required bool isDark,
  }) {
    final styles = AppTextStyles.build(
      textPrimary: colors.textPrimary,
      textSecondary: colors.textSecondary,
      textHint: colors.textHint,
      isArabic: isArabic,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      extensions: [colors, styles],

      colorScheme: isDark
          ? ColorScheme.dark(
              primary: colors.primary,
              primaryContainer: colors.primaryDark,
              secondary: colors.secondary,
              secondaryContainer: colors.secondaryLight,
              surface: colors.surface,
              error: colors.error,
              onPrimary: colors.onPrimary,
              onSecondary: colors.onSecondary,
              onSurface: colors.onSurface,
              onError: Colors.white,
              outline: colors.border,
              surfaceContainerHighest: colors.surfaceVariant,
            )
          : ColorScheme.light(
              primary: colors.primary,
              primaryContainer: colors.primaryLight,
              secondary: colors.secondary,
              secondaryContainer: colors.secondaryLight,
              surface: colors.surface,
              error: colors.error,
              onPrimary: colors.onPrimary,
              onSecondary: colors.onSecondary,
              onSurface: colors.onSurface,
              onError: Colors.white,
              outline: colors.border,
              surfaceContainerHighest: colors.surfaceVariant,
            ),

      scaffoldBackgroundColor: colors.background,

      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        ),
        titleTextStyle: styles.heading2,
        iconTheme: IconThemeData(color: colors.textPrimary, size: 22),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.navBackground,
        selectedItemColor: colors.navActive,
        unselectedItemColor: colors.navInactive,
        selectedLabelStyle: styles.navLabel.copyWith(
          color: colors.navActive,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: styles.navLabel.copyWith(color: colors.navInactive),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      cardTheme: CardThemeData(
        color: colors.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colors.border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.inputBackground,
        hintStyle: styles.inputHint,
        labelStyle: styles.inputLabel,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(color: colors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(color: colors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(color: colors.error, width: 1.5),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          textStyle: styles.buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 0,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF497981),
          textStyle: styles.labelMedium.copyWith(color: const Color(0xFF497981)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: colors.surfaceVariant,
        selectedColor: colors.primary,
        labelStyle: styles.labelSmall,
        side: BorderSide(color: colors.border),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: 1,
        space: 1,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colors.onPrimary;
          return colors.textHint;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colors.primary;
          return colors.border;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      textTheme: TextTheme(
        displayLarge: styles.displayLarge,
        displayMedium: styles.displayMedium,
        headlineLarge: styles.heading1,
        headlineMedium: styles.heading2,
        headlineSmall: styles.heading3,
        titleLarge: styles.heading3,
        titleMedium: styles.heading4,
        titleSmall: styles.labelLarge,
        bodyLarge: styles.bodyLarge,
        bodyMedium: styles.bodyMedium,
        bodySmall: styles.bodySmall,
        labelLarge: styles.labelLarge,
        labelMedium: styles.labelMedium,
        labelSmall: styles.labelSmall,
      ),

      iconTheme: IconThemeData(color: colors.textPrimary, size: 24),

      tabBarTheme: TabBarThemeData(
        labelColor: colors.primary,
        unselectedLabelColor: colors.textSecondary,
        indicatorColor: colors.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: styles.labelMedium.copyWith(color: colors.primary),
        unselectedLabelStyle: styles.labelMedium.copyWith(color: colors.textSecondary),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? colors.surface : colors.primaryDark,
        contentTextStyle: styles.bodyMedium.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static ThemeData light({bool isArabic = false}) => buildTheme(
        colors: AppColors.light,
        isArabic: isArabic,
        isDark: false,
      );

  static ThemeData dark({bool isArabic = false}) => buildTheme(
        colors: AppColors.dark,
        isArabic: isArabic,
        isDark: true,
      );
}
