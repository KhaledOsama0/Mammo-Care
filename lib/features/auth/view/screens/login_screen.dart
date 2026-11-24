import 'package:flutter/material.dart';
import '../../../../core/utils/context_ext.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(context.l10n.signIn),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle_outlined,
                size: 72,
                color: colors.primary,
              ),
              const SizedBox(height: 16),
              Text(
                context.l10n.welcomeBack,
                style: textStyles.heading1.copyWith(color: colors.primary),
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.signInSubtitle,
                textAlign: TextAlign.center,
                style: textStyles.bodyMedium.copyWith(color: colors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
