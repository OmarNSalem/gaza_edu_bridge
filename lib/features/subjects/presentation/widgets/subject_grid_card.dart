import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gaza_edu_bridge/core/router/route_names.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';
import 'package:gaza_edu_bridge/features/subjects/domain/entities/subject_entity.dart';

class SubjectGridCard extends StatelessWidget {
  const SubjectGridCard({super.key, required this.subject});

  final SubjectEntity subject;

  @override
  Widget build(BuildContext context) {
    final color = _colorFromHex(subject.colorHex);

    return Material(
      color: AppColors.cardBg,
      borderRadius: AppBorderRadius.roundedXl,
      child: InkWell(
        borderRadius: AppBorderRadius.roundedXl,
        onTap: () => context.go(RouteNames.resources, extra: subject.id),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: AppBorderRadius.roundedXl,
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: AppBorderRadius.roundedLg,
                    ),
                    child: Icon(_iconData(subject.icon),
                        size: 22, color: color),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: AppBorderRadius.roundedSm,
                    ),
                    child: Text(
                      '${subject.resourceCount} ملف',
                      style: AppTextStyles.badgeText.copyWith(
                        fontSize: 10,
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.name,
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subject.nameEn,
                    style: AppTextStyles.badgeText
                        .copyWith(fontSize: 10, color: AppColors.mutedText),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الصف ${subject.grade}',
                    style: AppTextStyles.badgeText
                        .copyWith(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.chevron_left_rounded,
                      size: 18, color: AppColors.mutedText),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _colorFromHex(String hex) {
    final h = hex.replaceAll('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }

  IconData _iconData(String icon) {
    return switch (icon) {
      'calculator' => Icons.calculate_outlined,
      'book' => Icons.menu_book_rounded,
      'flask' => Icons.science_outlined,
      'globe' => Icons.language_rounded,
      'landmark' => Icons.account_balance_outlined,
      'microscope' => Icons.biotech_outlined,
      _ => Icons.book_outlined,
    };
  }
}
