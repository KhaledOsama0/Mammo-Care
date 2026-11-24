import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/context_ext.dart';
import '../../view_model/splash_cubit.dart';
import '../../view_model/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..init(),
      child: const _SplashScreenView(),
    );
  }
}

class _SplashScreenView extends StatefulWidget {
  const _SplashScreenView();

  @override
  State<_SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<_SplashScreenView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _scaleAnimation = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
      ),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;

    final isDesktopOrWeb = context.isDesktopOrWeb;

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (!context.mounted) return;
        if (state is SplashNavigating) {
          switch (state.target) {
            case SplashNavigationTarget.onboarding:
              context.go(AppRoutes.onboarding);
              break;
            case SplashNavigationTarget.login:
              context.go(AppRoutes.login);
              break;
            case SplashNavigationTarget.home:
              context.go(AppRoutes.home);
              break;
          }
        }
      },
      child: Scaffold(
        backgroundColor:
            isDesktopOrWeb ? colors.surfaceVariant : colors.background,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Container(
              margin: isDesktopOrWeb
                  ? const EdgeInsets.symmetric(vertical: 24, horizontal: 16)
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
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(flex: 3),

                          // Logo with decorative soft glow background
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.surface,
                              boxShadow: [
                                BoxShadow(
                                  color: colors.secondary.withValues(alpha: 0.18),
                                  blurRadius: 20,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(22),
                            child: Image.asset(
                              'assets/images/logos/mammo.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/logos/logo.png',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.favorite_rounded,
                                      size: 68,
                                      color: colors.secondary,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 48), // Clear gap from logo shadow to title

                          // App Title
                        Text(
                          context.l10n.appName,
                          textAlign: TextAlign.center,
                          style: textStyles.brandName.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                            color: colors.primary,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Tagline
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            context.l10n.brandTagline,
                            textAlign: TextAlign.center,
                            style: textStyles.bodyLarge.copyWith(
                              color: colors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        const Spacer(flex: 2),

                        // Subtle animated loading indicator
                        

                        const SizedBox(height: 16),

                        // Subtitle disclaimer/branding
                        Text(
                          context.l10n.brandSubtitle,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textStyles.bodySmall.copyWith(
                            color: colors.textHint,
                            fontSize: 12,
                          ),
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}
