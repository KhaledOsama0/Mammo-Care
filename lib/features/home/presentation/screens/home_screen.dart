import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/locale_cubit.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/utils/context_ext.dart';
import '../../../auth/view_model/auth_cubit.dart';
import '../../../auth/view_model/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final styles = AppTextStyles.of(context);
    final l10n = context.l10n;
    final isDesktopOrWeb = context.isDesktopOrWeb;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.go(AppRoutes.login);
        }
      },
      builder: (context, state) {
        final authCubit = context.read<AuthCubit>();
        final user = state is Authenticated ? state.user : authCubit.currentUser;
        final displayName = user?.displayName ?? l10n.welcomeBack;
        final email = user?.email ?? '';

        final content = SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: isDesktopOrWeb ? 32.w : 20.w,
            vertical: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome User Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors.primary,
                      colors.primary.withValues(alpha: 0.85),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.28),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28.r,
                      backgroundColor: colors.surface.withValues(alpha: 0.2),
                      child: Text(
                        displayName.isNotEmpty
                            ? displayName.substring(0, 1).toUpperCase()
                            : 'M',
                        style: styles.heading1.copyWith(
                          color: colors.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.goodMorning,
                            style: styles.bodyMedium.copyWith(
                              color: colors.onPrimary.withValues(alpha: 0.85),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            displayName,
                            style: styles.heading2.copyWith(
                              color: colors.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (email.isNotEmpty) ...[
                            SizedBox(height: 2.h),
                            Text(
                              email,
                              style: styles.bodySmall.copyWith(
                                color: colors.onPrimary.withValues(alpha: 0.75),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Quick Actions Header
              Text(
                l10n.quickActions,
                style: styles.heading3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 12.h),

              // Action Cards Grid
              Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      context,
                      icon: Icons.camera_alt_rounded,
                      title: l10n.newAiScan,
                      color: colors.secondary,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildActionCard(
                      context,
                      icon: Icons.description_rounded,
                      title: l10n.viewReports,
                      color: colors.primary,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28.h),

              // Care Plan Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: colors.border.withValues(alpha: 0.6),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_rounded,
                          color: colors.primary,
                          size: 22.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          l10n.yourCarePlan,
                          style: styles.heading4.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      l10n.securelyStored,
                      style: styles.bodyMedium.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),

              // Sign Out Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final shouldLogout = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(l10n.signOut),
                        content: Text(
                          context.isRtl
                              ? 'هل أنت متأكد من رغبتك في تسجيل الخروج؟'
                              : 'Are you sure you want to sign out?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(false),
                            child: Text(l10n.cancel),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.of(ctx).pop(true),
                            style: FilledButton.styleFrom(
                              backgroundColor: colors.error,
                            ),
                            child: Text(l10n.signOut),
                          ),
                        ],
                      ),
                    );

                    if (shouldLogout == true && context.mounted) {
                      await context.read<AuthCubit>().signOut();
                    }
                  },
                  icon: Icon(
                    Icons.logout_rounded,
                    color: colors.error,
                    size: 20.sp,
                  ),
                  label: Text(
                    l10n.signOut,
                    style: styles.labelLarge.copyWith(
                      color: colors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: colors.error.withValues(alpha: 0.5),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );

        return Scaffold(
          backgroundColor:
              isDesktopOrWeb ? colors.surfaceVariant : colors.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text(
              l10n.appName,
              style: styles.heading3.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
            ),
            actions: [
              // Language Switcher
              InkWell(
                onTap: () {
                  context.read<LocaleCubit>().toggleLocale();
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              const SizedBox(width: 16),
            ],
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: content,
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    final colors = AppColors.of(context);
    final styles = AppTextStyles.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: colors.border.withValues(alpha: 0.6),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              style: styles.labelMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
