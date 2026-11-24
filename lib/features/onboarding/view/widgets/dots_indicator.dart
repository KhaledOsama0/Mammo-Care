import 'package:flutter/material.dart';
import '../../../../core/utils/context_ext.dart';

class DotsIndicator extends StatelessWidget {
  final int totalCount;
  final int currentIndex;

  const DotsIndicator({
    super.key,
    required this.totalCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalCount, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: isActive ? 28.0 : 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: isActive ? colors.primary : colors.border,
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}
