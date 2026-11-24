import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mammo_care/core/theme/app_colors.dart';
import 'package:mammo_care/core/theme/app_text_styles.dart';

class PassTextField extends StatelessWidget {
  const PassTextField({
    super.key,
    required this.hintTxt,
    required this.iconPath,
    required this.controller,
  });

  final String hintTxt;
  final String iconPath;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final styles = AppTextStyles.of(context);

    return SizedBox(
      height: 57.h,
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          fillColor: colors.inputBackground,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: colors.secondary,
              width: 1.5.w,
            ),
            borderRadius: BorderRadius.circular(14.r),
          ),
          prefixIcon: SvgPicture.asset(
            iconPath,
            fit: BoxFit.scaleDown,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: colors.inputBorder,
            ),
            borderRadius: BorderRadius.circular(14.r),
          ),
          hintText: hintTxt,
          hintStyle: styles.inputHint.copyWith(
            color: colors.textHint,
          ),
        ),
      ),
    );
  }
}
