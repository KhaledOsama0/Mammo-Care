import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/context_ext.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../view_model/auth_cubit.dart';
import '../../view_model/auth_state.dart';
import '../widgets/auth_footer_text.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_responsive_scaffold.dart';
import '../widgets/custom_text_field.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  void _onSendPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().sendPasswordReset(
            email: emailController.text.trim(),
            isArabic: context.isRtl,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = context.l10n;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PasswordResetSent) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                context.isRtl
                    ? 'تم إرسال رابط استعادة كلمة المرور إلى بريدك الإلكتروني.'
                    : 'Password reset link sent to your email.',
              ),
              backgroundColor: colors.primary,
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.push(AppRoutes.resetPassword);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: colors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

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
                  isLoading: isLoading,
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

        return AuthResponsiveScaffold(
          showBack: true,
          child: content,
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
