import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mammo_care/core/theme/app_colors.dart';
import 'package:mammo_care/core/widgets/custom_elevated_button.dart';
import 'package:mammo_care/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:mammo_care/features/auth/presentation/widgets/auth_footer_text.dart';
import 'package:mammo_care/features/auth/presentation/widgets/auth_header.dart';
import 'package:mammo_care/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:mammo_care/features/auth/presentation/widgets/pass_text_field.dart';
import 'package:mammo_care/l10n/app_localizations_en.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 44.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //*  header
                AuthHeader(
                    authTitle: 'Create a new password',
                    authSubTitle:
                        'Choose a strong password you haven’t used before.'),
                SizedBox(height: 28.h),

                //*email & pass textfields
                PassTextField(
                    hintTxt: AppLocalizationsEn().confirmPassword,
                    iconPath: 'iconPath',
                    controller: passController),
                SizedBox(height: 12.h),
                PassTextField(
                  hintTxt: AppLocalizationsEn().passwordHint,
                  iconPath: 'assets/icons/lock_icon.svg',
                  controller: passController,
                ),
                SizedBox(height: 46.h),

                //* login button

                CustomElevatedButton(
                  label: AppLocalizationsEn().resetPassword,
                  buttonClr: AppColors.of(context).primary,
                  labelClr: Colors.white,
                  onpressed: () {
                    // Login action
                  },
                ),
                SizedBox(height: 46.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    passController.dispose();

    super.dispose();
  }
}
