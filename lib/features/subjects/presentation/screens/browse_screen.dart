import 'package:flutter/material.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';
import 'package:gaza_edu_bridge/core/utils/mock_data.dart';
import 'package:gaza_edu_bridge/features/subjects/domain/entities/subject_entity.dart';
import 'package:gaza_edu_bridge/shared/widgets/app_header.dart';
import '../widgets/step_select_chip.dart';
import '../widgets/grade_select_chip.dart';
import '../widgets/branch_select_chip.dart';
import '../widgets/subject_grid_card.dart';

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
    _selectedLevel = switch (widget.initialLevelId) {
      'middle' => SchoolLevel.middle,
      'high' => SchoolLevel.high,
      _ => SchoolLevel.primary,
    };
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
    setState(() => _selectedGrade = grade);
  }

  void _onBranchChanged(SubjectBranch branch) {
    setState(() => _selectedBranch = branch);
  }

  List<SubjectEntity> get _filteredSubjects {
    final query = _searchController.text.trim().toLowerCase();
    return MockData.subjects.where((subject) {
      if (subject.level != _selectedLevel) return false;
      if (subject.grade != _selectedGrade) return false;
      if (_showBranchFilter && subject.branch != null) {
        if (subject.branch != _selectedBranch) return false;
      }
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
                        child: StepSelectChip(
                          label: 'الابتدائية',
                          isSelected: _selectedLevel == SchoolLevel.primary,
                          onTap: () => _onLevelChanged(SchoolLevel.primary),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: StepSelectChip(
                          label: 'الإعدادية',
                          isSelected: _selectedLevel == SchoolLevel.middle,
                          onTap: () => _onLevelChanged(SchoolLevel.middle),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: StepSelectChip(
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
                        return Padding(
                          padding: const EdgeInsets.only(left: AppSpacing.sm),
                          child: GradeSelectChip(
                            label: 'الصف $grade',
                            isSelected: _selectedGrade == grade,
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

          // ── 3. اختيار الفرع (صف 11 و 12 ثانوي) ──
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
                            child: BranchSelectChip(
                              label: 'الفرع العلمي',
                              isSelected:
                                  _selectedBranch == SubjectBranch.science,
                              onTap: () =>
                                  _onBranchChanged(SubjectBranch.science),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: BranchSelectChip(
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

          // ── قائمة كاردات المواد ──
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
                  (context, index) =>
                      SubjectGridCard(subject: filtered[index]),
                  childCount: filtered.length,
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
        ],
      ),
    );
  }

  String _levelTitle(SchoolLevel level) => switch (level) {
        SchoolLevel.primary => 'الابتدائية',
        SchoolLevel.middle => 'الإعدادية',
        SchoolLevel.high => 'الثانوية',
      };

  String _branchTitle(SubjectBranch branch) => switch (branch) {
        SubjectBranch.science => 'علمي',
        SubjectBranch.arts => 'أدبي',
      };
}
