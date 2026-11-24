import 'package:flutter/material.dart';
import '../../../../core/utils/context_ext.dart';

class OnboardingArtwork extends StatelessWidget {
  final int pageIndex;
  final double? size;

  const OnboardingArtwork({
    super.key,
    required this.pageIndex,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = context.isDark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final effectiveSize = size ?? (screenWidth * 0.52).clamp(180.0, 240.0);

    // Use the signature brand pink (colors.secondary) consistently across all pages
    final themeColor = colors.secondary;

    return Center(
      child: SizedBox(
        width: effectiveSize,
        height: effectiveSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer ambient glow ring
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: effectiveSize * 0.90,
              height: effectiveSize * 0.90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isDark ? colors.surfaceVariant : colors.surface)
                    .withValues(alpha: 0.7),
                boxShadow: [
                  BoxShadow(
                    color: themeColor.withValues(alpha: isDark ? 0.20 : 0.14),
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),

            // Decorative inner geometric backdrop
            Container(
              width: effectiveSize * 0.78,
              height: effectiveSize * 0.78,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    isDark
                        ? colors.surfaceVariant
                        : colors.secondaryLight.withValues(alpha: 0.35),
                    isDark ? colors.surface : colors.surface,
                  ],
                ),
                border: Border.all(
                  color: isDark
                      ? colors.border.withValues(alpha: 0.6)
                      : colors.secondaryLight.withValues(alpha: 0.8),
                  width: 2,
                ),
              ),
            ),

            // Main illustration per slide
            if (pageIndex == 0)
              // Page 1: Breast Health Ribbon Logo
              SizedBox(
                width: effectiveSize * 0.48,
                height: effectiveSize * 0.48,
                child: Image.asset(
                  'assets/images/logos/mammo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/images/logos/logo.png',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.favorite_rounded,
                      size: effectiveSize * 0.35,
                      color: colors.secondary,
                    ),
                  ),
                ),
              )
            else if (pageIndex == 1)
              // Page 2: Guided Care / Scans (matched with the logo & page 3 pink theme)
              Icon(
                Icons.monitor_heart_rounded,
                size: effectiveSize * 0.38,
                color: colors.secondary,
              )
            else
              // Page 3: Security & Encryption Shield
              Icon(
                Icons.verified_user_rounded,
                size: effectiveSize * 0.38,
                color: colors.secondary,
              ),

            // Orbiting accent badges
            Positioned(
              top: effectiveSize * 0.08,
              right: effectiveSize * 0.10,
              child: _buildSmallBadge(
                icon: pageIndex == 0
                    ? Icons.health_and_safety_outlined
                    : (pageIndex == 1
                        ? Icons.analytics_outlined
                        : Icons.lock_outline),
                color: colors.secondary,
                backgroundColor: colors.surface,
              ),
            ),
            Positioned(
              bottom: effectiveSize * 0.08,
              left: effectiveSize * 0.10,
              child: _buildSmallBadge(
                icon: pageIndex == 0
                    ? Icons.spa_outlined
                    : (pageIndex == 1
                        ? Icons.medical_services_outlined
                        : Icons.shield_outlined),
                color: colors.secondary,
                backgroundColor: colors.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallBadge({
    required IconData icon,
    required Color color,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }
}
