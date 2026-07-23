import 'package:flutter/material.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';

class StatsOverviewGrid extends StatelessWidget {
  const StatsOverviewGrid({
    super.key,
    required this.downloadCount,
    this.lastQuizScore,
  });

  final int downloadCount;
  final Map<String, int>? lastQuizScore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'التنزيلات',
            value: '$downloadCount',
            unit: 'ملفات أوفلاين',
            icon: Icons.download_done_rounded,
            color: AppColors.scienceAccent,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _StatCard(
            title: 'آخر اختبار',
            value: lastQuizScore != null
                ? '${((lastQuizScore!['score']! / lastQuizScore!['total']!) * 100).round()}%'
                : '—',
            unit: lastQuizScore != null
                ? '${lastQuizScore!['score']}/${lastQuizScore!['total']} إجابات'
                : 'لم تختبر بعد',
            icon: Icons.fact_check_outlined,
            color: AppColors.arabicAccent,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: AppBorderRadius.roundedXl,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.badgeText.copyWith(
                  fontSize: 11,
                  color: AppColors.mutedText,
                ),
              ),
              Icon(icon, size: 18, color: color),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTextStyles.cardTitle.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.foregroundText,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            unit,
            style: AppTextStyles.badgeText.copyWith(
              fontSize: 10,
              color: AppColors.mutedText,
            ),
          ),
        ],
      ),
    );
  }
}
