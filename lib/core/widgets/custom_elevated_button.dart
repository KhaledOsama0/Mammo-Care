import 'package:flutter/material.dart';
import 'package:mammo_care/core/theme/app_text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.label,
    required this.buttonClr,
    required this.labelClr,
    required this.onpressed,
    this.isLoading = false,
  });

  final String label;
  final Color buttonClr, labelClr;
  final VoidCallback? onpressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: isLoading ? null : onpressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: buttonClr,
          disabledBackgroundColor: buttonClr.withValues(alpha: 0.65),
          elevation: 2,
        ),
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(labelClr),
                ),
              )
            : Text(
                label,
                style: AppTextStyles.of(context)
                    .buttonText
                    .copyWith(color: labelClr, fontWeight: FontWeight.w700),
              ),
      ),
    );
  }
}
