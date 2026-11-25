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
import '../widgets/custom_text_field.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  bool _isLoading = false;

  void _onSendPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(milliseconds: 1200), () {
        if (mounted) {
          setState(() => _isLoading = false);
          context.push(AppRoutes.resetPassword);
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
              authTitle: l10n.forgotPassword,
              authSubTitle: l10n.forgotPasswordSubtitle,
            ),
            SizedBox(height: 32.h),

            // Email
            CustomTextField(
              hintTxt: l10n.emailHint,
              iconPath: 'assets/icons/msg_icon.svg',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _onSendPressed(),
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
            SizedBox(height: 36.h),

            // Button
            CustomElevatedButton(
              label: l10n.sendVerificationCode,
              buttonClr: colors.primary,
              labelClr: colors.onPrimary,
              isLoading: _isLoading,
              onpressed: _onSendPressed,
            ),
            SizedBox(height: 36.h),

            // Footer (Already have an account? Sign in)
            AuthFooterText(
              authFooterText1: l10n.alreadyHaveAccount,
              authFooterText2: l10n.signIn,
              onpressed: () {
                context.pop();
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
    emailController.dispose();
    super.dispose();
  }
}
