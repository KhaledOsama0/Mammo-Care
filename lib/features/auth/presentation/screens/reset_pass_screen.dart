import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/context_ext.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/auth_footer_text.dart';
import '../widgets/auth_header.dart';
import '../widgets/pass_text_field.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  bool _isLoading = false;

  void _onResetPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(milliseconds: 1200), () {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.resetPassword),
              backgroundColor: AppColors.of(context).primary,
            ),
          );
          context.go(AppRoutes.login);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
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
              authTitle: l10n.resetPassword,
              authSubTitle: l10n.resetPasswordSubtitle,
            ),
            SizedBox(height: 32.h),

            // New Password
            PassTextField(
              hintTxt: l10n.passwordHint,
              iconPath: 'assets/icons/lock_icon.svg',
              controller: passController,
              textInputAction: TextInputAction.next,
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
            SizedBox(height: 14.h),

            // Confirm New Password
            PassTextField(
              hintTxt: l10n.confirmPasswordHint,
              iconPath: 'assets/icons/lock_icon.svg',
              controller: confirmPassController,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _onResetPressed(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.requiredField;
                }
                if (value != passController.text) {
                  return l10n.passwordsDoNotMatch;
                }
                return null;
              },
            ),
            SizedBox(height: 36.h),

            // Reset Button
            CustomElevatedButton(
              label: l10n.resetPassword,
              buttonClr: colors.primary,
              labelClr: colors.onPrimary,
              isLoading: _isLoading,
              onpressed: _onResetPressed,
            ),
            SizedBox(height: 36.h),

            // Footer (Already have an account? Sign in)
            AuthFooterText(
              authFooterText1: l10n.alreadyHaveAccount,
              authFooterText2: l10n.signIn,
              onpressed: () {
                context.go(AppRoutes.login);
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
              appBar: const AuthAppBar(showBack: true),
              body: content,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }
}
