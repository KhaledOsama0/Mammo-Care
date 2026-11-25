import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/locale_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/utils/context_ext.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar({
    super.key,
    this.showBack = false,
    this.onBack,
  });

  final bool showBack;
  final VoidCallback? onBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final styles = AppTextStyles.of(context);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leading: showBack
          ? IconButton(
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
          : null,
      actions: [
        // Language Switcher
        InkWell(
          onTap: () {
            context.read<LocaleCubit>().toggleLocale();
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
    );
  }
}
