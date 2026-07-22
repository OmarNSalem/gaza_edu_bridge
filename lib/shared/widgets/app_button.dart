import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_border_radius.dart';

/// نوع الزر — primary بـ gradient أخضر، secondary بحد outlined
enum AppButtonVariant { primary, secondary }

/// زر موحّد يُستخدم في كل شاشات التطبيق
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.width = double.infinity,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final IconData? icon;
  final double width;

  @override
  Widget build(BuildContext context) {
    final isPrimary = variant == AppButtonVariant.primary;

    return SizedBox(
      width: width,
      height: 52,
      child: isPrimary
          ? DecoratedBox(
              decoration: BoxDecoration(
                gradient: onPressed == null
                    ? null
                    : AppColors.primaryButtonGradient,
                color: onPressed == null ? AppColors.border : null,
                borderRadius: AppBorderRadius.largeRadius,
              ),
              child: ElevatedButton(
                onPressed: isLoading ? null : onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.largeRadius,
                  ),
                ),
                child: _buildChild(isPrimary),
              ),
            )
          : OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.border),
                shape: const RoundedRectangleBorder(
                  borderRadius: AppBorderRadius.largeRadius,
                ),
              ),
              child: _buildChild(isPrimary),
            ),
    );
  }

  /// محتوى الزر — loading spinner أو أيقونة + نص
  Widget _buildChild(bool isPrimary) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: isPrimary ? Colors.white : AppColors.primary,
        ),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 18,
            color: isPrimary ? Colors.white : AppColors.foreground,
          ),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: AppTextStyles.button.copyWith(
            color: isPrimary ? Colors.white : AppColors.foreground,
          ),
        ),
      ],
    );
  }
}
