import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mammo_care/core/theme/app_colors.dart';
import 'package:mammo_care/core/theme/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintTxt,
    required this.iconPath,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final String hintTxt;
  final String iconPath;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final styles = AppTextStyles.of(context);

    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      style: styles.inputText.copyWith(color: colors.textPrimary),
      decoration: InputDecoration(
        fillColor: colors.inputBackground,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.primary,
            width: 1.5.w,
          ),
          borderRadius: BorderRadius.circular(14.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.inputBorder,
          ),
          borderRadius: BorderRadius.circular(14.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.error,
          ),
          borderRadius: BorderRadius.circular(14.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.error,
            width: 1.5.w,
          ),
          borderRadius: BorderRadius.circular(14.r),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: SvgPicture.asset(
            iconPath,
            width: 20.w,
            height: 20.h,
            fit: BoxFit.scaleDown,
            errorBuilder: (_, __, ___) => Icon(
              Icons.email_outlined,
              size: 20.sp,
              color: colors.textHint,
            ),
          ),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 44.w,
          minHeight: 24.h,
        ),
        hintText: hintTxt,
        hintStyle: styles.inputHint.copyWith(
          color: colors.textHint,
        ),
      ),
    );
  }
}
