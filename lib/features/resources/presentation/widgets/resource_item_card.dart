import 'package:flutter/material.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';
import 'package:gaza_edu_bridge/features/resources/domain/entities/resource_entity.dart';

class ResourceItemCard extends StatelessWidget {
  const ResourceItemCard({
    super.key,
    required this.resource,
    required this.isDownloaded,
    required this.isLoading,
    required this.onAction,
  });

  final ResourceEntity resource;
  final bool isDownloaded;
  final bool isLoading;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final catColor = _categoryColor(resource.category);

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: catColor.withValues(alpha: 0.12),
                  borderRadius: AppBorderRadius.roundedLg,
                ),
                child: Icon(_categoryIcon(resource.category),
                    size: 20, color: catColor),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resource.title,
                      style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      resource.description,
                      style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _BadgeInfo(
                    label: '${resource.fileSizeMb} MB',
                    icon: Icons.picture_as_pdf_outlined,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _BadgeInfo(
                    label: '${resource.pageCount} صفحة',
                    icon: Icons.description_outlined,
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: isLoading ? null : onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDownloaded
                      ? AppColors.secondary
                      : AppColors.primary,
                  foregroundColor:
                      isDownloaded ? AppColors.foregroundText : Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.roundedLg,
                  ),
                ),
                icon: isLoading
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Icon(
                        isDownloaded
                            ? Icons.menu_book_rounded
                            : Icons.download_rounded,
                        size: 16,
                      ),
                label: Text(
                  isLoading
                      ? 'تحميل...'
                      : isDownloaded
                          ? 'فتح الملف'
                          : 'تنزيل',
                  style: AppTextStyles.badgeText.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDownloaded
                        ? AppColors.foregroundText
                        : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _categoryColor(ResourceCategory category) => switch (category) {
        ResourceCategory.book => AppColors.arabicAccent,
        ResourceCategory.summary => AppColors.scienceAccent,
        ResourceCategory.exam => AppColors.chemistryAccent,
      };

  IconData _categoryIcon(ResourceCategory category) => switch (category) {
        ResourceCategory.book => Icons.menu_book_rounded,
        ResourceCategory.summary => Icons.assignment_outlined,
        ResourceCategory.exam => Icons.quiz_outlined,
      };
}

class _BadgeInfo extends StatelessWidget {
  const _BadgeInfo({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: AppBorderRadius.roundedSm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.mutedText),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.badgeText
                .copyWith(fontSize: 10, color: AppColors.mutedText),
          ),
        ],
      ),
    );
  }
}
