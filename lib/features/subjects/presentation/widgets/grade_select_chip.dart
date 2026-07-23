import 'package:flutter/material.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';

class GradeSelectChip extends StatelessWidget {
  const GradeSelectChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.scienceAccent.withValues(alpha: 0.15)
              : AppColors.cardBg,
          borderRadius: AppBorderRadius.roundedLg,
          border: Border.all(
            color: isSelected ? AppColors.scienceAccent : AppColors.border,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.badgeText.copyWith(
            fontSize: 12,
            color: isSelected
                ? AppColors.scienceAccent
                : AppColors.foregroundText,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
