import 'package:flutter/material.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';
import 'package:gaza_edu_bridge/features/resources/domain/entities/resource_entity.dart';

class DownloadedFileCard extends StatelessWidget {
  const DownloadedFileCard({
    super.key,
    required this.file,
    required this.onOpen,
    required this.onDelete,
  });

  final ResourceEntity file;
  final VoidCallback onOpen;
  final VoidCallback onDelete;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.12),
                  borderRadius: AppBorderRadius.roundedLg,
                ),
                child: const Icon(Icons.picture_as_pdf_rounded,
                    size: 20, color: AppColors.success),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.title,
                      style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      file.description,
                      style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded,
                    size: 20, color: AppColors.error),
                onPressed: onDelete,
                tooltip: 'حذف الملف',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: AppBorderRadius.roundedSm,
                    ),
                    child: Text(
                      '${file.fileSizeMb} MB',
                      style: AppTextStyles.badgeText
                          .copyWith(fontSize: 10, color: AppColors.mutedText),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: AppBorderRadius.roundedSm,
                    ),
                    child: Text(
                      'جاهز أوفلاين',
                      style: AppTextStyles.badgeText.copyWith(
                          fontSize: 10,
                          color: AppColors.success,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: onOpen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.roundedLg,
                  ),
                ),
                icon: const Icon(Icons.menu_book_rounded, size: 16),
                label: Text(
                  'قراءة',
                  style: AppTextStyles.badgeText.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
