import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/locale_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/utils/context_ext.dart';
import 'auth_app_bar.dart';

class AuthResponsiveScaffold extends StatelessWidget {
  const AuthResponsiveScaffold({
    super.key,
    required this.child,
    this.showBack = false,
    this.onBack,
  });

  final Widget child;
  final bool showBack;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDesktop = MediaQuery.sizeOf(context).width >= 900;

    if (!isDesktop) {
      // Mobile / Tablet Clean Fullscreen Layout (No fake phone borders)
      return Scaffold(
        backgroundColor: colors.background,
        appBar: AuthAppBar(
          showBack: showBack,
          onBack: onBack,
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: child,
          ),
        ),
      );
    }

    // Modern Web / Desktop Split Screen Layout
    return Scaffold(
      backgroundColor: colors.background,
      body: Row(
        children: [
          // Left Pane (Branded Hero Showcase)
          Expanded(
            flex: 5,
            child: _buildHeroPane(context),
          ),

          // Right Pane (Authentication Form Panel)
          Expanded(
            flex: 6,
            child: _buildFormPane(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroPane(BuildContext context) {
    final colors = AppColors.of(context);
    final styles = AppTextStyles.of(context);
    final l10n = context.l10n;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.primary,
            colors.primary.withValues(alpha: 0.88),
            colors.secondary.withValues(alpha: 0.78),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Decorative background circles
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),

          // Hero Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand Header with Icon
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/images/logos/mammo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.favorite_rounded,
                          color: colors.primary,
                          size: 26,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      l10n.appName,
                      style: styles.heading2.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 2),

                // Main Tagline & Subtitle
                Text(
                  l10n.brandTagline,
                  style: styles.displayMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 34,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.brandSubtitle,
                  style: styles.bodyLarge.copyWith(
                    color: Colors.white.withValues(alpha: 0.88),
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 36),

                // 3 Benefit Highlights
                _buildBenefitItem(
                  icon: Icons.shield_rounded,
                  title: l10n.onboardingTitle3,
                  subtitle: l10n.onboardingBody3,
                ),
                const SizedBox(height: 20),
                _buildBenefitItem(
                  icon: Icons.auto_awesome_rounded,
                  title: l10n.onboardingTitle1,
                  subtitle: l10n.onboardingBody1,
                ),
                const SizedBox(height: 20),
                _buildBenefitItem(
                  icon: Icons.medical_services_rounded,
                  title: l10n.onboardingTitle2,
                  subtitle: l10n.onboardingBody2,
                ),

                const Spacer(flex: 3),

                // Trust footer
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.lock_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          context.isRtl
                              ? 'بياناتك الصحية مشفرة ومحمية بأعلى معايير الأمان.'
                              : 'Your clinical data is end-to-end encrypted and secure.',
                          style: styles.caption.copyWith(
                            color: Colors.white.withValues(alpha: 0.92),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 13,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormPane(BuildContext context) {
    final colors = AppColors.of(context);
    final styles = AppTextStyles.of(context);

    return SafeArea(
      child: Column(
        children: [
          // Top Bar with Back, Language and Theme controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showBack)
                  IconButton(
                    onPressed: onBack ?? () => context.pop(),
                    tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                    icon: Icon(
                      context.isRtl
                          ? Icons.arrow_forward_ios_rounded
                          : Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: colors.textPrimary,
                    ),
                  )
                else
                  const SizedBox.shrink(),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Language Switcher
                    InkWell(
                      onTap: () {
                        context.read<LocaleCubit>().toggleLocale();
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: colors.surfaceVariant,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: colors.border.withValues(alpha: 0.8),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.language_rounded,
                              size: 15,
                              color: colors.primary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              context.isRtl ? 'EN' : 'عربي',
                              style: styles.labelMedium.copyWith(
                                color: colors.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Theme Toggle
                    IconButton(
                      icon: Icon(
                        context.isDark
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                        size: 20,
                        color: colors.textSecondary,
                      ),
                      tooltip: 'Toggle Theme',
                      onPressed: () {
                        context.read<ThemeCubit>().toggleTheme();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Center Scrollable Form Area
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
