import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/locale_cubit.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/utils/context_ext.dart';
import '../../model/onboarding_item.dart';
import '../../view_model/onboarding_cubit.dart';
import '../../view_model/onboarding_state.dart';
import '../widgets/dots_indicator.dart';
import '../widgets/onboarding_slide_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: const _OnboardingScreenView(),
    );
  }
}

class _OnboardingScreenView extends StatefulWidget {
  const _OnboardingScreenView();

  @override
  State<_OnboardingScreenView> createState() => _OnboardingScreenViewState();
}

class _OnboardingScreenViewState extends State<_OnboardingScreenView> {
  late final PageController _pageController;

  static final List<OnboardingItem> _slides = [
    OnboardingItem(
      getTitle: (ctx) => ctx.l10n.onboardingTitle1,
      getBody: (ctx) => ctx.l10n.onboardingBody1,
      icon: Icons.favorite_rounded,
      badgeColor: const Color(0xFFDFA6B9),
    ),
    OnboardingItem(
      getTitle: (ctx) => ctx.l10n.onboardingTitle2,
      getBody: (ctx) => ctx.l10n.onboardingBody2,
      icon: Icons.monitor_heart_rounded,
      badgeColor: const Color(0xFFDFA6B9),
    ),
    OnboardingItem(
      getTitle: (ctx) => ctx.l10n.onboardingTitle3,
      getBody: (ctx) => ctx.l10n.onboardingBody3,
      icon: Icons.verified_user_rounded,
      badgeColor: const Color(0xFFDFA6B9),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed(BuildContext context, OnboardingState state) {
    if (state.isLastPage) {
      context.read<OnboardingCubit>().completeOnboarding();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onSkipPressed(BuildContext context) {
    context.read<OnboardingCubit>().completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;
    final isDesktopOrWeb = context.isDesktopOrWeb;

    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state.isCompleted && context.mounted) {
          context.go(AppRoutes.login);
        }
      },
      builder: (context, state) {
        return Scaffold(
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
                  child: Column(
                    children: [
                      // Top Header (Skip button + Language/Theme Switcher)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 12.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Language & Theme Toggle Buttons
                            Row(
                              children: [
                                // Language Switcher
                                InkWell(
                                  onTap: () {
                                    context.read<LocaleCubit>().toggleLocale();
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colors.surfaceVariant,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: colors.border
                                            .withValues(alpha: 0.8),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.language_rounded,
                                          size: 16,
                                          color: colors.primary,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          context.isRtl ? 'EN' : 'عربي',
                                          style:
                                              textStyles.labelMedium.copyWith(
                                            color: colors.primary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),

                                // Theme Toggle
                                IconButton(
                                  icon: Icon(
                                    context.isDark
                                        ? Icons.light_mode_outlined
                                        : Icons.dark_mode_outlined,
                                    size: 20,
                                    color: colors.textSecondary,
                                  ),
                                  tooltip: 'Toggle Theme',
                                  onPressed: () {
                                    context.read<ThemeCubit>().toggleTheme();
                                  },
                                ),
                              ],
                            ),

                            // Skip Button
                            AnimatedOpacity(
                              opacity: state.isLastPage ? 0.0 : 1.0,
                              duration: const Duration(milliseconds: 200),
                              child: TextButton(
                                onPressed: state.isLastPage
                                    ? null
                                    : () => _onSkipPressed(context),
                                style: TextButton.styleFrom(
                                  foregroundColor: colors.textSecondary,
                                  textStyle: textStyles.labelLarge.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                child: Text(context.l10n.skipForNow),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Center Slides (PageView) with Web/Desktop mouse & touch drag support
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                              PointerDeviceKind.trackpad,
                              PointerDeviceKind.stylus,
                            },
                          ),
                          child: PageView.builder(
                            controller: _pageController,
                            physics: const BouncingScrollPhysics(),
                            itemCount: _slides.length,
                            onPageChanged: (index) {
                              context.read<OnboardingCubit>().onPageChanged(index);
                            },
                            itemBuilder: (context, index) {
                              return OnboardingSlideWidget(
                                item: _slides[index],
                                pageIndex: index,
                              );
                            },
                          ),
                        ),
                      ),

                      // Bottom Navigation (Dots + Action Button)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(28.0, 16.0, 28.0, 36.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Dots Indicator
                            DotsIndicator(
                              totalCount: _slides.length,
                              currentIndex: state.currentPage,
                            ),
                            const SizedBox(height: 28),

                            // Main Action Button ("Continue" or "Get Started")
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: () => _onNextPressed(context, state),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colors.primary,
                                  foregroundColor: colors.onPrimary,
                                  elevation: 2,
                                  shadowColor: colors.shadow,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state.isLastPage
                                          ? context.l10n.getStarted
                                          : context.l10n.continueButton,
                                      style: textStyles.labelLarge.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: colors.onPrimary,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      context.isRtl
                                          ? Icons.arrow_back_rounded
                                          : Icons.arrow_forward_rounded,
                                      size: 20,
                                      color: colors.onPrimary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
