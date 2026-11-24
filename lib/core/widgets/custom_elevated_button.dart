import 'package:flutter/material.dart';
import 'package:mammo_care/core/theme/app_text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.label,
    required this.buttonClr,
    required this.labelClr,
    required this.onpressed,
  });

  final String label;
  final Color buttonClr, labelClr;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 57),
        backgroundColor: buttonClr,
      ),
      child: Text(
        label,
        style: AppTextStyles.of(context).buttonText.copyWith(color: labelClr),
      ),
    );
  }
}
