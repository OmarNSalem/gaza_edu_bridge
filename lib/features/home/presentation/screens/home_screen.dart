import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gaza_edu_bridge/core/router/route_names.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';
import 'package:gaza_edu_bridge/features/subjects/domain/entities/subject_entity.dart';
import 'package:gaza_edu_bridge/shared/widgets/app_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.lastSubject,
    this.lastQuizScore,
    this.downloadCount = 0,
    this.isGuest = false,
  });

  final SubjectEntity? lastSubject;
  final Map<String, int>? lastQuizScore; // {score, total}
  final int downloadCount;
  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'GazaEdu Bridge',
        subtitle: isGuest ? 'وضع الضيف' : 'الرئيسية',
        showLogout: true,
        onLogout: () => context.go(RouteNames.auth),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // بانر الضيف
              if (isGuest)
                _GuestBanner(onRegister: () => context.go(RouteNames.auth)),
              // بانر الترحيب
              _WelcomeBanner(),
              // إحصائيات النشاط
              const _SectionTitle(title: 'نشاطي الأخير'),
              _ActivityStats(
                downloadCount: downloadCount,
                lastSubject: lastSubject,
                lastQuizScore: lastQuizScore,
              ),
              // آخر مادة
              if (lastSubject != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: _LastSubjectCard(subject: lastSubject!),
                ),
              ],
              // اختيار المرحلة
              const _SectionTitle(title: 'اختر مرحلتك الدراسية'),
              _LevelCards(),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Banner الضيف ─────────────────────────────────────────────────────────────

class _GuestBanner extends StatelessWidget {
  const _GuestBanner({required this.onRegister});
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 0),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.historyAccent.withValues(alpha: 0.08),
          borderRadius: AppBorderRadius.roundedXl,
          border:
              Border.all(color: AppColors.historyAccent.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.historyAccent.withValues(alpha: 0.13),
                borderRadius: AppBorderRadius.roundedMd,
              ),
              child: const Icon(Icons.person_outline_rounded,
                  size: 18, color: AppColors.historyAccent),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('أنت في وضع الضيف',
                      style: AppTextStyles.badgeText.copyWith(
                          color: AppColors.historyAccent,
                          fontWeight: FontWeight.w700,
                          fontSize: 11)),
                  Text('سجّل لحفظ تقدمك وملفاتك',
                      style: AppTextStyles.badgeText.copyWith(fontSize: 10)),
                ],
              ),
            ),
            GestureDetector(
              onTap: onRegister,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE3B341), Color(0xFFB8912A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: AppBorderRadius.roundedLg,
                ),
                child: Text('سجّل',
                    style: AppTextStyles.badgeText.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── بانر الترحيب ──────────────────────────────────────────────────────────────

class _WelcomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color(0xFFEDEDED),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFD4D4D4)),
        ),
        child: Stack(
          children: [
            // الدائرة التزيينية المثالية في أقصى الزاوية العليا اليسرى
            Positioned(
              left: -45,
              top: -45,
              child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFDBDBDB),
                ),
              ),
            ),
            // المحتوى والنصوص داخل Padding منفصل
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'GazaEdu Bridge',
                      style: AppTextStyles.badgeText.copyWith(
                        color: const Color(0xFF6E6E6E),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'مرحباً بك',
                      style: AppTextStyles.cardTitle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'استمر في رحلتك التعليمية',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: const Color(0xFF888888),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── عنوان القسم ────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.sm),
      child: Text(title, style: AppTextStyles.cardTitle),
    );
  }
}

// ─── إحصائيات النشاط ──────────────────────────────────────────────────────

class _ActivityStats extends StatelessWidget {
  const _ActivityStats({
    required this.downloadCount,
    required this.lastSubject,
    required this.lastQuizScore,
  });

  final int downloadCount;
  final SubjectEntity? lastSubject;
  final Map<String, int>? lastQuizScore;

  @override
  Widget build(BuildContext context) {
    final scorePercent = lastQuizScore != null
        ? ((lastQuizScore!['score']! / lastQuizScore!['total']!) * 100).round()
        : null;
    final scoreColor = scorePercent == null
        ? AppColors.mutedText
        : scorePercent >= 70
            ? AppColors.primary
            : scorePercent >= 50
                ? const Color(0xFFD97706)
                : AppColors.error;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              icon: Icons.download_rounded,
              iconColor: AppColors.scienceAccent,
              value: '$downloadCount',
              label: 'ملف محمّل',
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _StatCard(
              icon: Icons.assignment_outlined,
              iconColor: scoreColor,
              value: scorePercent != null ? '$scorePercent%' : '—',
              label: 'آخر اختبار',
              valueColor: scoreColor,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _StatCard(
              icon: Icons.menu_book_rounded,
              iconColor: AppColors.arabicAccent,
              value: lastSubject != null ? '1+' : '0',
              label: 'مادة فُتحت',
              valueColor: AppColors.arabicAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    this.valueColor,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final Color? valueColor;

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
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.13),
              borderRadius: AppBorderRadius.roundedMd,
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTextStyles.sectionTitle.copyWith(
              fontSize: 20,
              color: valueColor ?? AppColors.scienceAccent,
            ),
          ),
          Text(
            label,
            style: AppTextStyles.badgeText.copyWith(fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─── آخر مادة ─────────────────────────────────────────────────────────────

class _LastSubjectCard extends StatelessWidget {
  const _LastSubjectCard({required this.subject});
  final SubjectEntity subject;

  @override
  Widget build(BuildContext context) {
    final color = _colorFromHex(subject.colorHex);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.1), Colors.white],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: AppBorderRadius.roundedXl,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.13),
              borderRadius: AppBorderRadius.roundedLg,
            ),
            child: Icon(_iconData(subject.icon), size: 20, color: color),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('آخر مادة فُتحت',
                    style: AppTextStyles.badgeText.copyWith(fontSize: 10)),
                Text(subject.name,
                    style: AppTextStyles.bodyMedium
                        .copyWith(fontWeight: FontWeight.w700)),
                Text(
                  '${_levelLabel(subject.level)} — السنة ${subject.grade}',
                  style: AppTextStyles.badgeText
                      .copyWith(color: color, fontSize: 11),
                ),
              ],
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: AppBorderRadius.roundedLg,
            ),
            child: Icon(Icons.chevron_left, size: 18, color: color),
          ),
        ],
      ),
    );
  }
}

// ─── بطاقات المراحل الدراسية ─────────────────────────────────────────────

class _LevelCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const levels = [
      _LevelData(
          id: 'primary',
          ar: 'المرحلة الابتدائية',
          en: 'Primary School',
          grades: 'السنوات 1–6'),
      _LevelData(
          id: 'middle',
          ar: 'المرحلة الإعدادية',
          en: 'Middle School',
          grades: 'السنوات 7–9'),
      _LevelData(
          id: 'high',
          ar: 'المرحلة الثانوية',
          en: 'High School',
          grades: 'السنوات 10–12'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        children: levels.map((level) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: _LevelCard(level: level),
          );
        }).toList(),
      ),
    );
  }
}

class _LevelData {
  const _LevelData({
    required this.id,
    required this.ar,
    required this.en,
    required this.grades,
  });

  final String id;
  final String ar;
  final String en;
  final String grades;
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({required this.level});
  final _LevelData level;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFE8E8E8),
      borderRadius: AppBorderRadius.roundedXl,
      child: InkWell(
        borderRadius: AppBorderRadius.roundedXl,
        onTap: () => context.go(RouteNames.browse, extra: level.id),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: AppBorderRadius.roundedXl,
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.33)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(level.ar, style: AppTextStyles.cardTitle),
                    const SizedBox(height: 2),
                    Text(level.en,
                        style: AppTextStyles.badgeText
                            .copyWith(color: AppColors.primary)),
                    const SizedBox(height: 4),
                    Text(level.grades, style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.13),
                  borderRadius: AppBorderRadius.roundedLg,
                ),
                child: const Icon(Icons.school_outlined,
                    size: 24, color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Helpers ──────────────────────────────────────────────────────────────

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

String _levelLabel(SchoolLevel level) {
  return switch (level) {
    SchoolLevel.primary => 'ابتدائي',
    SchoolLevel.middle => 'إعدادي',
    SchoolLevel.high => 'ثانوي',
  };
}
