import 'package:flutter/material.dart';
import 'package:mammo_care/core/theme/app_colors.dart';
import 'package:mammo_care/core/theme/app_text_styles.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.authTitle,
    required this.authSubTitle,
  });

  final String authTitle, authSubTitle;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    final styles = AppTextStyles.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          authTitle,
          style: styles.heading1.copyWith(
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          authSubTitle,
          style: styles.bodyMedium.copyWith(
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
