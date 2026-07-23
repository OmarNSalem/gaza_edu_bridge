import 'package:flutter/material.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.showBack = false,
    this.onBack,
    this.showLogout = false,
    this.onLogout,
    this.actions,
  });

  final String title;
  final String? subtitle;
  final bool showBack;
  final VoidCallback? onBack;
  final bool showLogout;
  final VoidCallback? onLogout;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AppBar(
        backgroundColor: AppColors.cardBg,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.border),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Row(
          children: [
            if (showBack)
              GestureDetector(
                onTap: onBack ?? () => Navigator.of(context).pop(),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.chevron_right, size: 22, color: AppColors.foregroundText),
                ),
              )
            else
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.school_outlined, size: 18, color: Colors.white),
              ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: AppTextStyles.cardTitle.copyWith(fontSize: 15)),
                if (subtitle != null)
                  Text(subtitle!, style: AppTextStyles.badgeText.copyWith(fontSize: 11)),
              ],
            ),
          ],
        ),
        actions: [
          if (showLogout && onLogout != null)
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: TextButton.icon(
                onPressed: onLogout,
                icon: const Icon(Icons.logout_rounded, size: 16, color: AppColors.error),
                label: Text('خروج', style: AppTextStyles.badgeText.copyWith(color: AppColors.error, fontWeight: FontWeight.w600)),
              ),
            ),
          ...?actions,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
