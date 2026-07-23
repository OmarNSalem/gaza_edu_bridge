import 'package:flutter/material.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  final String label;
  final Widget icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.cardBg,
        foregroundColor: textColor ?? AppColors.foregroundText,
        side: BorderSide(color: borderColor ?? AppColors.border),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.roundedXl,
        ),
      ),
      icon: icon,
      label: Text(
        label,
        style: AppTextStyles.buttonText.copyWith(
          color: textColor ?? AppColors.foregroundText,
          fontSize: 14,
        ),
      ),
    );
  }
}
