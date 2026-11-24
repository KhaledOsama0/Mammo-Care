import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mammo_care/core/theme/app_colors.dart';
import 'package:mammo_care/core/theme/app_text_styles.dart';
import 'package:mammo_care/core/widgets/custom_elevated_button.dart';
import 'package:mammo_care/features/auth/presentation/screens/forgot_pass_screen.dart';
import 'package:mammo_care/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:mammo_care/features/auth/presentation/widgets/auth_footer_text.dart';
import 'package:mammo_care/features/auth/presentation/widgets/auth_header.dart';
import 'package:mammo_care/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:mammo_care/features/auth/presentation/widgets/pass_text_field.dart';
import 'package:mammo_care/l10n/app_localizations_en.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
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
                //* login screen header
                AuthHeader(
                    authTitle: AppLocalizationsEn().welcomeBack,
                    authSubTitle: AppLocalizationsEn().signInSubtitle),
                SizedBox(height: 28.h),

                //*email & pass textfields
                CustomTextField(
                  hintTxt: AppLocalizationsEn().emailHint,
                  iconPath: 'assets/icons/msg_icon.svg',
                  controller: emailController,
                ),
                SizedBox(height: 12.h),
                PassTextField(
                  hintTxt: AppLocalizationsEn().passwordHint,
                  iconPath: 'assets/icons/lock_icon.svg',
                  controller: passController,
                ),
                SizedBox(height: 46.h),

                //* login button

                CustomElevatedButton(
                  label: AppLocalizationsEn().signIn,
                  buttonClr: AppColors.of(context).primary,
                  labelClr: Colors.white,
                  onpressed: () {
                    // Login action
                  },
                ),
                SizedBox(height: 12.h),

                Row(
                  children: [
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassScreen()),
                        );
                      },
                      child: Text(
                        AppLocalizationsEn().forgotPassword,
                        style: AppTextStyles.of(context).labelMedium.copyWith(
                              color: AppColors.of(context).secondary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 46.h),

                //* footer text
                AuthFooterText(
                  authFooterText1: 'New to Clarity?',
                  authFooterText2: AppLocalizationsEn().createAccount,
                  onpressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                ),
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
    emailController.dispose();

    super.dispose();
  }
}
