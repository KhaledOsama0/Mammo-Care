import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mammo_care/core/theme/app_colors.dart';
import 'package:mammo_care/core/theme/app_text_styles.dart';

class AuthFooterText extends StatelessWidget {
  const AuthFooterText({
    super.key,
    required this.authFooterText1,
    required this.authFooterText2,
    required this.onpressed,
  });

  final String authFooterText1;
  final String authFooterText2;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final styles = AppTextStyles.of(context);

    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            authFooterText1,
            style: styles.bodyMedium.copyWith(
              color: colors.textSecondary,
              fontSize: 14.sp,
            ),
          ),
          TextButton(
            onPressed: onpressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              minimumSize: Size(0, 40.h),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              authFooterText2,
              style: styles.bodyMedium.copyWith(
                color: colors.secondary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
