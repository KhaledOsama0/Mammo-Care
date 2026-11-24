import 'package:flutter/material.dart';

/// Mammo Care Text Styles
/// Manrope → Headings/Brand | DMSans → Body/UI | Cairo → Arabic
@immutable
class AppTextStyles extends ThemeExtension<AppTextStyles> {
  const AppTextStyles({
    required this.displayLarge,
    required this.displayMedium,
    required this.heading1,
    required this.heading2,
    required this.heading3,
    required this.heading4,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.caption,
    required this.overline,
    required this.brandName,
    required this.navLabel,
    required this.buttonText,
    required this.inputLabel,
    required this.inputText,
    required this.inputHint,
    required this.badgeText,
    required this.sectionHeader,
  });

  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle heading1;
  final TextStyle heading2;
  final TextStyle heading3;
  final TextStyle heading4;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;
  final TextStyle caption;
  final TextStyle overline;
  final TextStyle brandName;
  final TextStyle navLabel;
  final TextStyle buttonText;
  final TextStyle inputLabel;
  final TextStyle inputText;
  final TextStyle inputHint;
  final TextStyle badgeText;
  final TextStyle sectionHeader;

  static AppTextStyles of(BuildContext context) =>
      Theme.of(context).extension<AppTextStyles>()!;

  static AppTextStyles build({
    required Color textPrimary,
    required Color textSecondary,
    required Color textHint,
    required bool isArabic,
  }) {
    final heading = isArabic ? 'Cairo' : 'Manrope';
    final body = isArabic ? 'Cairo' : 'DMSans';

    return AppTextStyles(
      displayLarge: TextStyle(
        fontFamily: heading, fontSize: 40,
        fontWeight: FontWeight.w700, letterSpacing: -1.5,
        color: textPrimary, height: 1.1,
      ),
      displayMedium: TextStyle(
        fontFamily: heading, fontSize: 33,
        fontWeight: FontWeight.w600, letterSpacing: -1.32,
        color: textPrimary, height: 1.13,
      ),
      heading1: TextStyle(
        fontFamily: heading, fontSize: 26,
        fontWeight: FontWeight.w700, letterSpacing: -0.5,
        color: textPrimary, height: 1.25,
      ),
      heading2: TextStyle(
        fontFamily: heading, fontSize: 21,
        fontWeight: FontWeight.w700, letterSpacing: -0.3,
        color: textPrimary, height: 1.3,
      ),
      heading3: TextStyle(
        fontFamily: heading, fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary, height: 1.35,
      ),
      heading4: TextStyle(
        fontFamily: heading, fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimary, height: 1.4,
      ),
      bodyLarge: TextStyle(
        fontFamily: body, fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textPrimary, height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: body, fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textPrimary, height: 1.5,
      ),
      bodySmall: TextStyle(
        fontFamily: body, fontSize: 13,
        fontWeight: FontWeight.w400,
        color: textSecondary, height: 1.5,
      ),
      labelLarge: TextStyle(
        fontFamily: body, fontSize: 15,
        fontWeight: FontWeight.w700,
        color: textPrimary, height: 1.3,
      ),
      labelMedium: TextStyle(
        fontFamily: body, fontSize: 13,
        fontWeight: FontWeight.w700,
        color: textPrimary, height: 1.3,
      ),
      labelSmall: TextStyle(
        fontFamily: body, fontSize: 11,
        fontWeight: FontWeight.w700,
        color: textSecondary, letterSpacing: 0.5, height: 1.3,
      ),
      caption: TextStyle(
        fontFamily: body, fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textSecondary, height: 1.4,
      ),
      overline: TextStyle(
        fontFamily: body, fontSize: 11,
        fontWeight: FontWeight.w700,
        color: textSecondary, letterSpacing: 1.32, height: 1.4,
      ),
      brandName: const TextStyle(
        fontFamily: 'Manrope', fontSize: 11,
        fontWeight: FontWeight.w700, letterSpacing: 1.32,
        color: Color(0xFFD5E9EF), height: 1.4,
      ),
      navLabel: TextStyle(
        fontFamily: body, fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textSecondary, height: 1.3,
      ),
      buttonText: const TextStyle(
        fontFamily: 'DMSans', fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Colors.white, height: 1.4,
      ),
      inputLabel: const TextStyle(
        fontFamily: 'DMSans', fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Color(0xFF497981), letterSpacing: 0.2, height: 1.5,
      ),
      inputText: TextStyle(
        fontFamily: body, fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textPrimary, height: 1.5,
      ),
      inputHint: TextStyle(
        fontFamily: body, fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textHint, height: 1.5,
      ),
      badgeText: const TextStyle(
        fontFamily: 'DMSans', fontSize: 11,
        fontWeight: FontWeight.w600, height: 1.2,
      ),
      sectionHeader: TextStyle(
        fontFamily: body, fontSize: 11,
        fontWeight: FontWeight.w700, letterSpacing: 1.1,
        color: textSecondary, height: 1.4,
      ),
    );
  }

  @override
  AppTextStyles copyWith({
    TextStyle? displayLarge, TextStyle? displayMedium,
    TextStyle? heading1, TextStyle? heading2, TextStyle? heading3, TextStyle? heading4,
    TextStyle? bodyLarge, TextStyle? bodyMedium, TextStyle? bodySmall,
    TextStyle? labelLarge, TextStyle? labelMedium, TextStyle? labelSmall,
    TextStyle? caption, TextStyle? overline,
    TextStyle? brandName, TextStyle? navLabel, TextStyle? buttonText,
    TextStyle? inputLabel, TextStyle? inputText, TextStyle? inputHint,
    TextStyle? badgeText, TextStyle? sectionHeader,
  }) => AppTextStyles(
    displayLarge: displayLarge ?? this.displayLarge,
    displayMedium: displayMedium ?? this.displayMedium,
    heading1: heading1 ?? this.heading1,
    heading2: heading2 ?? this.heading2,
    heading3: heading3 ?? this.heading3,
    heading4: heading4 ?? this.heading4,
    bodyLarge: bodyLarge ?? this.bodyLarge,
    bodyMedium: bodyMedium ?? this.bodyMedium,
    bodySmall: bodySmall ?? this.bodySmall,
    labelLarge: labelLarge ?? this.labelLarge,
    labelMedium: labelMedium ?? this.labelMedium,
    labelSmall: labelSmall ?? this.labelSmall,
    caption: caption ?? this.caption,
    overline: overline ?? this.overline,
    brandName: brandName ?? this.brandName,
    navLabel: navLabel ?? this.navLabel,
    buttonText: buttonText ?? this.buttonText,
    inputLabel: inputLabel ?? this.inputLabel,
    inputText: inputText ?? this.inputText,
    inputHint: inputHint ?? this.inputHint,
    badgeText: badgeText ?? this.badgeText,
    sectionHeader: sectionHeader ?? this.sectionHeader,
  );

  @override
  AppTextStyles lerp(AppTextStyles? other, double t) {
    if (other is! AppTextStyles) return this;
    return AppTextStyles(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      heading1: TextStyle.lerp(heading1, other.heading1, t)!,
      heading2: TextStyle.lerp(heading2, other.heading2, t)!,
      heading3: TextStyle.lerp(heading3, other.heading3, t)!,
      heading4: TextStyle.lerp(heading4, other.heading4, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      overline: TextStyle.lerp(overline, other.overline, t)!,
      brandName: TextStyle.lerp(brandName, other.brandName, t)!,
      navLabel: TextStyle.lerp(navLabel, other.navLabel, t)!,
      buttonText: TextStyle.lerp(buttonText, other.buttonText, t)!,
      inputLabel: TextStyle.lerp(inputLabel, other.inputLabel, t)!,
      inputText: TextStyle.lerp(inputText, other.inputText, t)!,
      inputHint: TextStyle.lerp(inputHint, other.inputHint, t)!,
      badgeText: TextStyle.lerp(badgeText, other.badgeText, t)!,
      sectionHeader: TextStyle.lerp(sectionHeader, other.sectionHeader, t)!,
    );
  }
}
