import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mammo_care/core/theme/app_colors.dart';
import 'package:mammo_care/core/widgets/custom_elevated_button.dart';
import 'package:mammo_care/features/auth/presentation/screens/login_screen.dart';
import 'package:mammo_care/features/auth/presentation/widgets/auth_footer_text.dart';
import 'package:mammo_care/features/auth/presentation/widgets/auth_header.dart';
import 'package:mammo_care/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:mammo_care/l10n/app_localizations_en.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final TextEditingController emailController = TextEditingController();

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
                //* header
                AuthHeader(
                    authTitle: AppLocalizationsEn().forgotPassword,
                    authSubTitle:
                        'Enter your email and we’ll send you a secure verification code.'),
                SizedBox(height: 28.h),

                //*email
                CustomTextField(
                  hintTxt: AppLocalizationsEn().emailHint,
                  iconPath: 'assets/icons/msg_icon.svg',
                  controller: emailController,
                ),

                SizedBox(height: 46.h),

                //* elevated button

                CustomElevatedButton(
                  label: 'Send verification code',
                  buttonClr: AppColors.of(context).primary,
                  labelClr: Colors.white,
                  onpressed: () {
                    //  action
                  },
                ),
                SizedBox(height: 46.h),

                //* footer text
                AuthFooterText(
                  authFooterText1: 'Remembered it?',
                  authFooterText2: 'Back to sign in',
                  onpressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LogInScreen()),
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
    emailController.dispose();

    super.dispose();
  }
}
