import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';
import 'package:gaza_edu_bridge/core/utils/mock_data.dart';
import 'package:gaza_edu_bridge/features/resources/domain/entities/resource_entity.dart';
import 'package:gaza_edu_bridge/features/subjects/domain/entities/subject_entity.dart';
import 'package:gaza_edu_bridge/shared/widgets/app_header.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key, this.subjectId});

  final String? subjectId;

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  ResourceCategory? _selectedTab;
  late SubjectEntity _subject;
  late List<ResourceEntity> _subjectResources;
  final Map<String, bool> _downloadState = {};
  final Map<String, bool> _loadingState = {};

  @override
  void initState() {
    super.initState();
    // الحصول على المادة المحددة أو المادة الافتراضية الأولى
    final targetId = widget.subjectId ?? 'math-h12-sci';
    _subject = MockData.subjects.firstWhere(
      (s) => s.id == targetId,
      orElse: () => MockData.subjects.first,
    );

    // تصفية الموارد التابعة لهذه المادة
    _subjectResources = MockData.resources
        .where((r) => r.subjectId == _subject.id)
        .toList();

    // إذا لم تكن هناك موارد معرفة لهذه المادة بالذات في Mock Data، نولد موارد افتراضية غنية
    if (_subjectResources.isEmpty) {
      _subjectResources = [
        ResourceEntity(
          id: '${_subject.id}-book',
          subjectId: _subject.id,
          title: 'كتاب ${_subject.name} - المنهج الوزاري الكامل',
          description: 'الكتاب المدرسي المعتمد لوزارة التربية والتعليم للعام الدراسي الحالي.',
          category: ResourceCategory.book,
          fileSizeMb: 12.5,
          pageCount: 150,
          downloadUrl: 'https://example.com/book.pdf',
        ),
        ResourceEntity(
          id: '${_subject.id}-summary',
          subjectId: _subject.id,
          title: 'ملخص شامل لجميع الوحدات والإجابات',
          description: 'شرح مبسط وملخص مفيد للمراجعة قبل الامتحانات النهائية.',
          category: ResourceCategory.summary,
          fileSizeMb: 4.8,
          pageCount: 40,
          downloadUrl: 'https://example.com/summary.pdf',
        ),
        ResourceEntity(
          id: '${_subject.id}-exam',
          subjectId: _subject.id,
          title: 'نماذج امتحانات وتدريبات مجابة',
          description: 'تجميع أسئلة واختبارات سابقة للم التدرب والاختبار الذاتي.',
          category: ResourceCategory.exam,
          fileSizeMb: 6.1,
          pageCount: 52,
          downloadUrl: 'https://example.com/exam.pdf',
        ),
      ];
    }
  }

  void _handleDownload(ResourceEntity res) async {
    final isDownloaded = _downloadState[res.id] ?? res.isDownloaded;
    if (isDownloaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('جاري فتح الملف: ${res.title}'),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _loadingState[res.id] = true;
    });

    // محاكاة تنزيل الملف
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() {
      _loadingState[res.id] = false;
      _downloadState[res.id] = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم تنزيل ${res.title} بنجاح'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  List<ResourceEntity> get _filteredResources {
    if (_selectedTab == null) return _subjectResources;
    return _subjectResources
        .where((r) => r.category == _selectedTab)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredResources;
    final color = _colorFromHex(_subject.colorHex);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: _subject.name,
        subtitle: 'الصف ${_subject.grade} ${_levelLabel(_subject.level)}',
        showBack: true,
        onBack: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else {
            context.go('/browse');
          }
        },
      ),
      body: Column(
        children: [
          // ── Subject Info Header ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              border: const Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: AppBorderRadius.roundedXl,
                  ),
                  child: Icon(_iconData(_subject.icon), size: 26, color: color),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_subject.name,
                          style: AppTextStyles.cardTitle.copyWith(fontSize: 16)),
                      const SizedBox(height: 2),
                      Text(
                        '${_levelLabel(_subject.level)} — الصف ${_subject.grade}${_subject.branch != null ? " (${_branchLabel(_subject.branch!)})" : ""}',
                        style: AppTextStyles.badgeText
                            .copyWith(color: AppColors.mutedText, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: AppBorderRadius.roundedMd,
                  ),
                  child: Text(
                    '${_subjectResources.length} ملفات',
                    style: AppTextStyles.badgeText.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Category Tabs ──
          Container(
            color: AppColors.cardBg,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
              child: Row(
                children: [
                  _TabButton(
                    label: 'الكل (${_subjectResources.length})',
                    isSelected: _selectedTab == null,
                    onTap: () => setState(() => _selectedTab = null),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _TabButton(
                    label: 'الكتب الوزارية',
                    isSelected: _selectedTab == ResourceCategory.book,
                    onTap: () =>
                        setState(() => _selectedTab = ResourceCategory.book),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _TabButton(
                    label: 'الملخصات والشروحات',
                    isSelected: _selectedTab == ResourceCategory.summary,
                    onTap: () =>
                        setState(() => _selectedTab = ResourceCategory.summary),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _TabButton(
                    label: 'الامتحانات الوزارية',
                    isSelected: _selectedTab == ResourceCategory.exam,
                    onTap: () =>
                        setState(() => _selectedTab = ResourceCategory.exam),
                  ),
                ],
              ),
            ),
          ),

          const Divider(height: 1, color: AppColors.border),

          // ── Resource List ──
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.folder_open_rounded,
                            size: 48, color: AppColors.mutedText),
                        const SizedBox(height: AppSpacing.md),
                        Text('لا توجد ملفات بهذا التصنيف',
                            style: AppTextStyles.cardTitle),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final res = filtered[index];
                      final isDownloaded =
                          _downloadState[res.id] ?? res.isDownloaded;
                      final isLoading = _loadingState[res.id] ?? false;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: _ResourceCard(
                          resource: res,
                          isDownloaded: isDownloaded,
                          isLoading: isLoading,
                          onAction: () => _handleDownload(res),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ─── Component Tab Button ───────────────────────────────────────────────────

class _TabButton extends StatelessWidget {
  const _TabButton({
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.secondary,
          borderRadius: AppBorderRadius.roundedLg,
        ),
        child: Text(
          label,
          style: AppTextStyles.badgeText.copyWith(
            color: isSelected ? Colors.white : AppColors.foregroundText,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

// ─── Resource Card Widget ───────────────────────────────────────────────────

class _ResourceCard extends StatelessWidget {
  const _ResourceCard({
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
              // معلومات الملف (الحجم والمفحات)
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

              // زر التنزيل أو الفتح
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

Color _categoryColor(ResourceCategory category) {
  return switch (category) {
    ResourceCategory.book => AppColors.arabicAccent,
    ResourceCategory.summary => AppColors.scienceAccent,
    ResourceCategory.exam => AppColors.chemistryAccent,
  };
}

IconData _categoryIcon(ResourceCategory category) {
  return switch (category) {
    ResourceCategory.book => Icons.menu_book_rounded,
    ResourceCategory.summary => Icons.assignment_outlined,
    ResourceCategory.exam => Icons.quiz_outlined,
  };
}

String _levelLabel(SchoolLevel level) {
  return switch (level) {
    SchoolLevel.primary => 'ابتدائي',
    SchoolLevel.middle => 'إعدادي',
    SchoolLevel.high => 'ثانوي',
  };
}

String _branchLabel(SubjectBranch branch) {
  return switch (branch) {
    SubjectBranch.science => 'علمي',
    SubjectBranch.arts => 'أدبي',
  };
}
