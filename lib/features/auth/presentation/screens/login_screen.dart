import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/context_ext.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/auth_footer_text.dart';
import '../widgets/auth_header.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/pass_text_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool _isLoading = false;

  void _onSignInPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(milliseconds: 1200), () {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final styles = AppTextStyles.of(context);
    final l10n = context.l10n;
    final isDesktopOrWeb = context.isDesktopOrWeb;

    final content = SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 16.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            AuthHeader(
              authTitle: l10n.welcomeBack,
              authSubTitle: l10n.signInSubtitle,
            ),
            SizedBox(height: 32.h),

            // Email Field
            CustomTextField(
              hintTxt: l10n.emailHint,
              iconPath: 'assets/icons/msg_icon.svg',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.requiredField;
                }
                final emailRegex =
                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value.trim())) {
                  return l10n.invalidEmail;
                }
                return null;
              },
            ),
            SizedBox(height: 14.h),

            // Password Field
            PassTextField(
              hintTxt: l10n.passwordHint,
              iconPath: 'assets/icons/lock_icon.svg',
              controller: passController,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _onSignInPressed(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.requiredField;
                }
                if (value.length < 6) {
                  return l10n.passwordTooShort;
                }
                return null;
              },
            ),
            SizedBox(height: 10.h),

            // Forgot Password Link
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () {
                  context.push(AppRoutes.forgotPassword);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  l10n.forgotPassword,
                  style: styles.labelMedium.copyWith(
                    color: colors.secondary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h),

            // Sign In Button
            CustomElevatedButton(
              label: l10n.signIn,
              buttonClr: colors.primary,
              labelClr: colors.onPrimary,
              isLoading: _isLoading,
              onpressed: _onSignInPressed,
            ),
            SizedBox(height: 36.h),

            // Footer Text
            AuthFooterText(
              authFooterText1: l10n.newToApp,
              authFooterText2: l10n.createAccount,
              onpressed: () {
                context.push(AppRoutes.register);
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor:
          isDesktopOrWeb ? colors.surfaceVariant : colors.background,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Container(
            margin: isDesktopOrWeb
                ? const EdgeInsets.symmetric(vertical: 28, horizontal: 16)
                : EdgeInsets.zero,
            decoration: isDesktopOrWeb
                ? BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: colors.shadow.withValues(alpha: 0.10),
                        blurRadius: 28,
                        spreadRadius: 0,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(
                      color: colors.border.withValues(alpha: 0.6),
                    ),
                  )
                : null,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: const AuthAppBar(showBack: false),
              body: content,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
