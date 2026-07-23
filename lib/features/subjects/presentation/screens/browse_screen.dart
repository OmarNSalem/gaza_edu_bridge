import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gaza_edu_bridge/core/router/route_names.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';
import 'package:gaza_edu_bridge/core/utils/mock_data.dart';
import 'package:gaza_edu_bridge/features/subjects/domain/entities/subject_entity.dart';
import 'package:gaza_edu_bridge/shared/widgets/app_header.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key, this.initialLevelId});

  final String? initialLevelId;

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  late SchoolLevel _selectedLevel;
  late int _selectedGrade;
  SubjectBranch _selectedBranch = SubjectBranch.science;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // إعداد المرحلة الافتراضية
    _selectedLevel = switch (widget.initialLevelId) {
      'middle' => SchoolLevel.middle,
      'high' => SchoolLevel.high,
      _ => SchoolLevel.primary,
    };
    // إعداد السنة الافتراضية بناءً على المرحلة
    _selectedGrade = _defaultGradeForLevel(_selectedLevel);
  }

  int _defaultGradeForLevel(SchoolLevel level) {
    return switch (level) {
      SchoolLevel.primary => 1,
      SchoolLevel.middle => 7,
      SchoolLevel.high => 10,
    };
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<int> get _availableGrades {
    return switch (_selectedLevel) {
      SchoolLevel.primary => [1, 2, 3, 4, 5, 6],
      SchoolLevel.middle => [7, 8, 9],
      SchoolLevel.high => [10, 11, 12],
    };
  }

  bool get _showBranchFilter {
    return _selectedLevel == SchoolLevel.high &&
        (_selectedGrade == 11 || _selectedGrade == 12);
  }

  void _onLevelChanged(SchoolLevel level) {
    setState(() {
      _selectedLevel = level;
      _selectedGrade = _defaultGradeForLevel(level);
      _selectedBranch = SubjectBranch.science;
    });
  }

  void _onGradeChanged(int grade) {
    setState(() {
      _selectedGrade = grade;
    });
  }

  void _onBranchChanged(SubjectBranch branch) {
    setState(() {
      _selectedBranch = branch;
    });
  }

  List<SubjectEntity> get _filteredSubjects {
    final query = _searchController.text.trim().toLowerCase();
    return MockData.subjects.where((subject) {
      // 1. فلتر المرحلة الإجباري
      if (subject.level != _selectedLevel) return false;

      // 2. فلتر الصف الإجباري
      if (subject.grade != _selectedGrade) return false;

      // 3. فلتر الفرع الإجباري (للصف 11 و 12 ثانوي فقط)
      if (_showBranchFilter && subject.branch != null) {
        if (subject.branch != _selectedBranch) return false;
      }

      // 4. حقل البحث
      if (query.isNotEmpty) {
        final matchAr = subject.name.toLowerCase().contains(query);
        final matchEn = subject.nameEn.toLowerCase().contains(query);
        if (!matchAr && !matchEn) return false;
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredSubjects;
    final grades = _availableGrades;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(
        title: 'تصفح المواد',
        subtitle: 'المناهج الدراسية الفلسطينية',
      ),
      body: CustomScrollView(
        slivers: [
          // ── حقل البحث ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.sm),
              child: TextField(
                controller: _searchController,
                style: AppTextStyles.bodyMedium,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'ابحث عن مادة (مثل: رياضيات، علوم)...',
                  hintStyle: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.mutedText),
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: AppColors.mutedText, size: 20),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close_rounded,
                              color: AppColors.mutedText, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: AppColors.cardBg,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: AppBorderRadius.roundedXl,
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: AppBorderRadius.roundedXl,
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: AppBorderRadius.roundedXl,
                    borderSide: const BorderSide(
                        color: AppColors.primary, width: 1.5),
                  ),
                ),
              ),
            ),
          ),

          // ── 1. اختيار المرحلة الدراسية ──
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg, 4, AppSpacing.lg, 6),
                  child: Text(
                    '1. اختر المرحلة الدراسية',
                    style: AppTextStyles.badgeText.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.foregroundText,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Row(
                    children: [
                      Expanded(
                        child: _StepSelectChip(
                          label: 'الابتدائية',
                          isSelected: _selectedLevel == SchoolLevel.primary,
                          onTap: () => _onLevelChanged(SchoolLevel.primary),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _StepSelectChip(
                          label: 'الإعدادية',
                          isSelected: _selectedLevel == SchoolLevel.middle,
                          onTap: () => _onLevelChanged(SchoolLevel.middle),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _StepSelectChip(
                          label: 'الثانوية',
                          isSelected: _selectedLevel == SchoolLevel.high,
                          onTap: () => _onLevelChanged(SchoolLevel.high),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── 2. اختيار السنة / الصف ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg, 0, AppSpacing.lg, 6),
                    child: Text(
                      '2. اختر السنة الدراسية',
                      style: AppTextStyles.badgeText.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.foregroundText,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg),
                    child: Row(
                      children: grades.map((grade) {
                        final isSel = _selectedGrade == grade;
                        return Padding(
                          padding: const EdgeInsets.only(left: AppSpacing.sm),
                          child: _GradeSelectChip(
                            label: 'الصف $grade',
                            isSelected: isSel,
                            onTap: () => _onGradeChanged(grade),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── 3. اختيار الفرع (تظهر فقط للثانوية - صف 11 و 12) ──
          if (_showBranchFilter)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          AppSpacing.lg, 0, AppSpacing.lg, 6),
                      child: Text(
                        '3. اختر الفرع والتخصص',
                        style: AppTextStyles.badgeText.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.arabicAccent,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg),
                      child: Row(
                        children: [
                          Expanded(
                            child: _BranchSelectChip(
                              label: 'الفرع العلمي',
                              isSelected:
                                  _selectedBranch == SubjectBranch.science,
                              onTap: () =>
                                  _onBranchChanged(SubjectBranch.science),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: _BranchSelectChip(
                              label: 'الفرع الأدبي',
                              isSelected:
                                  _selectedBranch == SubjectBranch.arts,
                              onTap: () =>
                                  _onBranchChanged(SubjectBranch.arts),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

          // ── عنوان المواد المعروضة ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, AppSpacing.xs, AppSpacing.lg, AppSpacing.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'مواد ${_levelTitle(_selectedLevel)} — الصف $_selectedGrade${_showBranchFilter ? " (${_branchTitle(_selectedBranch)})" : ""}',
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 15),
                  ),
                  Text(
                    '${filtered.length} مادة متاحة',
                    style: AppTextStyles.badgeText
                        .copyWith(color: AppColors.mutedText),
                  ),
                ],
              ),
            ),
          ),

          // ── قائمة كاردات المواد المرتبة ──
          if (filtered.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.search_off_rounded,
                          size: 32, color: AppColors.mutedText),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text('لا توجد مواد مضافة لهذا الصف حالياً',
                        style: AppTextStyles.cardTitle),
                    const SizedBox(height: 4),
                    Text('اختر صفاً دراسياً آخر لعرض المواد',
                        style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final subject = filtered[index];
                    return _SubjectGridCard(subject: subject);
                  },
                  childCount: filtered.length,
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
        ],
      ),
    );
  }

  String _levelTitle(SchoolLevel level) {
    return switch (level) {
      SchoolLevel.primary => 'الابتدائية',
      SchoolLevel.middle => 'الإعدادية',
      SchoolLevel.high => 'الثانوية',
    };
  }

  String _branchTitle(SubjectBranch branch) {
    return switch (branch) {
      SubjectBranch.science => 'علمي',
      SubjectBranch.arts => 'أدبي',
    };
  }
}

// ─── Component Chips ─────────────────────────────────────────────────────────

class _StepSelectChip extends StatelessWidget {
  const _StepSelectChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.cardBg,
          borderRadius: AppBorderRadius.roundedLg,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.badgeText.copyWith(
            fontSize: 13,
            color: isSelected ? Colors.white : AppColors.foregroundText,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _GradeSelectChip extends StatelessWidget {
  const _GradeSelectChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.scienceAccent.withValues(alpha: 0.15)
              : AppColors.cardBg,
          borderRadius: AppBorderRadius.roundedLg,
          border: Border.all(
            color: isSelected ? AppColors.scienceAccent : AppColors.border,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.badgeText.copyWith(
            fontSize: 12,
            color:
                isSelected ? AppColors.scienceAccent : AppColors.foregroundText,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _BranchSelectChip extends StatelessWidget {
  const _BranchSelectChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.arabicAccent.withValues(alpha: 0.15)
              : AppColors.cardBg,
          borderRadius: AppBorderRadius.roundedLg,
          border: Border.all(
            color: isSelected ? AppColors.arabicAccent : AppColors.border,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.badgeText.copyWith(
            fontSize: 12,
            color:
                isSelected ? AppColors.arabicAccent : AppColors.mutedText,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ─── Subject Grid Card ────────────────────────────────────────────────────────

class _SubjectGridCard extends StatelessWidget {
  const _SubjectGridCard({required this.subject});

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
