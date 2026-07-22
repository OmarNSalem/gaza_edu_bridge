import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_border_radius.dart';

/// عرض حالة القائمة الفارغة مع رسالة توجيهية
class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({
    super.key,
    required this.message,
    this.subMessage,
    this.icon = Icons.inbox_outlined,
  });

  final String message;
  final String? subMessage;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColors.card,
                borderRadius: AppBorderRadius.extraLargeRadius,
              ),
              child: Icon(icon, color: AppColors.mutedForeground, size: 36),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              message,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.foreground),
              textAlign: TextAlign.center,
            ),
            if (subMessage != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                subMessage!,
                style: AppTextStyles.caption
                    .copyWith(color: AppColors.mutedForeground),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
