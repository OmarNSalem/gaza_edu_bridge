import 'package:flutter/material.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({
    super.key,
    required this.isGuest,
    required this.onLoginTap,
  });

  final bool isGuest;
  final VoidCallback onLoginTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: AppBorderRadius.roundedXl,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isGuest) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.12),
                borderRadius: AppBorderRadius.roundedSm,
              ),
              child: Text(
                'وضع الضيف',
                style: AppTextStyles.badgeText.copyWith(
                  color: AppColors.warning,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          Text(
            'مرحباً بك',
            style: AppTextStyles.cardTitle.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'استمر في رحلتك التعليمية واختبر معلوماتك بسهولة',
            style: AppTextStyles.bodySmall.copyWith(
              color: const Color(0xFF6B7C72),
              fontSize: 13,
            ),
          ),
          if (isGuest) ...[
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onLoginTap,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.roundedLg,
                  ),
                ),
                child: Text(
                  'تسجيل الدخول لمزامنة تقدمك',
                  style: AppTextStyles.badgeText.copyWith(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
