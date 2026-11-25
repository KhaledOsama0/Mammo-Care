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
import '../widgets/pass_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  void _onSignUpPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().signUp(
            email: emailController.text.trim(),
            password: passController.text,
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
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
        if (state is Authenticated) {
          context.go(AppRoutes.home);
        } else if (state is AuthSignUpSuccess) {
          if (state.needsEmailConfirmation) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  context.isRtl
                      ? 'تم إنشاء الحساب بنجاح! يرجى مراجعة بريدك الإلكتروني لتأكيد حسابك.'
                      : 'Account created! Please check your email to confirm your account.',
                ),
                backgroundColor: colors.primary,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 4),
              ),
            );
            context.go(AppRoutes.login);
          } else {
            context.go(AppRoutes.home);
          }
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
                  authTitle: l10n.createAccount,
                  authSubTitle: l10n.signUpSubtitle,
                ),
                SizedBox(height: 28.h),

                // First and Last Name row
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintTxt: l10n.firstNameHint,
                        iconPath: 'assets/icons/person.svg',
                        controller: firstNameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.requiredField;
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomTextField(
                        hintTxt: l10n.lastNameHint,
                        iconPath: 'assets/icons/person.svg',
                        controller: lastNameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.requiredField;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),

                // Email
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

                // Password
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

                // Confirm Password
                PassTextField(
                  hintTxt: l10n.confirmPasswordHint,
                  iconPath: 'assets/icons/lock_icon.svg',
                  controller: confirmPassController,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _onSignUpPressed(),
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
                SizedBox(height: 32.h),

                // Submit Button
                CustomElevatedButton(
                  label: l10n.createAccount,
                  buttonClr: colors.primary,
                  labelClr: colors.onPrimary,
                  isLoading: isLoading,
                  onpressed: _onSignUpPressed,
                ),
                SizedBox(height: 32.h),

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
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }
}
