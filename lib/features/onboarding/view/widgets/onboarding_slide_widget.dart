import 'package:flutter/material.dart';
import '../../../../core/utils/context_ext.dart';
import '../../model/onboarding_item.dart';
import 'onboarding_artwork.dart';

class OnboardingSlideWidget extends StatelessWidget {
  final OnboardingItem item;
  final int pageIndex;

  const OnboardingSlideWidget({
    super.key,
    required this.item,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;

    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            OnboardingArtwork(pageIndex: pageIndex),
            const SizedBox(height: 48),

            // Slide Title
            Text(
              item.getTitle(context),
              textAlign: TextAlign.center,
              style: textStyles.heading1.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 18),

            // Slide Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                item.getBody(context),
                textAlign: TextAlign.center,
                style: textStyles.bodyLarge.copyWith(
                  color: colors.textSecondary,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
