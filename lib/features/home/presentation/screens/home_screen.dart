import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gaza_edu_bridge/core/router/route_names.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';
import 'package:gaza_edu_bridge/features/subjects/domain/entities/subject_entity.dart';
import 'package:gaza_edu_bridge/shared/widgets/app_header.dart';
import '../widgets/welcome_banner.dart';
import '../widgets/stats_overview_grid.dart';
import '../widgets/level_selection_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.lastSubject,
    this.lastQuizScore,
    this.downloadCount = 0,
    this.isGuest = false,
  });

  final SubjectEntity? lastSubject;
  final Map<String, int>? lastQuizScore;
  final int downloadCount;
  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(
        title: 'جسر التعليم في غزة',
        subtitle: 'المكتبة المدرسية الإلكترونية',
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // ── بانر الترحبب ──
          WelcomeBanner(
            isGuest: isGuest,
            onLoginTap: () => context.go(RouteNames.auth),
          ),

          const SizedBox(height: AppSpacing.lg),

          // ── الإحصائيات المختصرة ──
          StatsOverviewGrid(
            downloadCount: downloadCount,
            lastQuizScore: lastQuizScore,
          ),

          const SizedBox(height: AppSpacing.xl),

          // ── قسم اختيار المرحلة ──
          Text(
            'اختر المرحلة الدراسية',
            style: AppTextStyles.sectionTitle,
          ),
          const SizedBox(height: AppSpacing.sm),

          LevelSelectionCard(
            title: 'المرحلة الابتدائية',
            subtitle: 'الصفوف من 1 إلى 6',
            grades: '1 - 6',
            icon: Icons.child_care_rounded,
            color: AppColors.scienceAccent,
            onTap: () => context.go(RouteNames.browse, extra: 'primary'),
          ),

          const SizedBox(height: AppSpacing.md),

          LevelSelectionCard(
            title: 'المرحلة الإعدادية',
            subtitle: 'الصفوف من 7 إلى 9',
            grades: '7 - 9',
            icon: Icons.school_outlined,
            color: AppColors.arabicAccent,
            onTap: () => context.go(RouteNames.browse, extra: 'middle'),
          ),

          const SizedBox(height: AppSpacing.md),

          LevelSelectionCard(
            title: 'المرحلة الثانوية (توجيهي)',
            subtitle: 'الصفوف 10 إلى 12 - أدبي وعلمي',
            grades: '10 - 12',
            icon: Icons.workspace_premium_outlined,
            color: AppColors.chemistryAccent,
            onTap: () => context.go(RouteNames.browse, extra: 'high'),
          ),

          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}
