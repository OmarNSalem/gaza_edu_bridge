import 'package:flutter/material.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';

class QuizDropdownField<T> extends StatelessWidget {
  const QuizDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.enabled = true,
  });

  final String label;
  final T? value;
  final String hint;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: AppTextStyles.badgeText.copyWith(
              color: AppColors.foregroundText,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<T>(
            initialValue: value,
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.mutedText,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: enabled ? Colors.white : AppColors.secondary,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: AppBorderRadius.roundedLg,
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppBorderRadius.roundedLg,
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppBorderRadius.roundedLg,
                borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: AppBorderRadius.roundedLg,
                borderSide: const BorderSide(color: AppColors.border),
              ),
            ),
            hint: Text(
              hint,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.mutedText),
            ),
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.foregroundText),
            items: enabled ? items : [],
            onChanged: enabled ? onChanged : null,
          ),
        ],
      ),
    );
  }
}
