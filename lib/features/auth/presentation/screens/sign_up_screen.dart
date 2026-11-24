import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mammo_care/core/theme/app_colors.dart';
import 'package:mammo_care/core/widgets/custom_elevated_button.dart';
import 'package:mammo_care/features/auth/presentation/widgets/auth_footer_text.dart';
import 'package:mammo_care/features/auth/presentation/widgets/auth_header.dart';
import 'package:mammo_care/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:mammo_care/features/auth/presentation/widgets/pass_text_field.dart';
import 'package:mammo_care/l10n/app_localizations_en.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 44),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeader(
                  authTitle: AppLocalizationsEn().createAccount,
                  authSubTitle:
                      'A secure space for your scans, reports, and care team.',
                ),
                SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintTxt: 'Fisrt name',
                        iconPath: 'assets/icons/person.svg',
                        controller: firstNameController,
                      ),
                    ),
                    SizedBox(width: 20.h),
                    Expanded(
                      child: CustomTextField(
                        hintTxt: 'Last name',
                        iconPath: 'assets/icons/person.svg',
                        controller: lastNameController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                CustomTextField(
                  hintTxt: AppLocalizationsEn().emailHint,
                  iconPath: 'assets/icons/msg_icon.svg',
                  controller: emailController,
                ),
                SizedBox(height: 12),
                PassTextField(
                  hintTxt: AppLocalizationsEn().passwordHint,
                  iconPath: 'assets/icons/lock_icon.svg',
                  controller: passController,
                ),
                SizedBox(height: 12),
                CustomElevatedButton(
                  label: 'sign up',
                  buttonClr: AppColors.of(context).primary,
                  labelClr: Colors.white,
                  onpressed: () {
                    // Login action
                  },
                ),
                SizedBox(height: 16),
                AuthFooterText(
                  authFooterText1: AppLocalizationsEn().alreadyHaveAccount,
                  authFooterText2: AppLocalizationsEn().signIn,
                  onpressed: () {
                    Navigator.pop(context);
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
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
