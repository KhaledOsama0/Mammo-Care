import 'package:flutter/material.dart';

class OnboardingItem {
  final String Function(BuildContext context) getTitle;
  final String Function(BuildContext context) getBody;
  final IconData icon;
  final Color badgeColor;

  const OnboardingItem({
    required this.getTitle,
    required this.getBody,
    required this.icon,
    required this.badgeColor,
  });
}
