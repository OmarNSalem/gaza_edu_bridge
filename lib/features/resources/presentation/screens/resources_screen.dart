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
import '../widgets/resource_tab_button.dart';
import '../widgets/resource_item_card.dart';

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
    final targetId = widget.subjectId ?? 'math-h12-sci';
    _subject = MockData.subjects.firstWhere(
      (s) => s.id == targetId,
      orElse: () => MockData.subjects.first,
    );

    _subjectResources = MockData.resources
        .where((r) => r.subjectId == _subject.id)
        .toList();

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

    setState(() => _loadingState[res.id] = true);
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
          Container(
            color: AppColors.cardBg,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
              child: Row(
                children: [
                  ResourceTabButton(
                    label: 'الكل (${_subjectResources.length})',
                    isSelected: _selectedTab == null,
                    onTap: () => setState(() => _selectedTab = null),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ResourceTabButton(
                    label: 'الكتب الوزارية',
                    isSelected: _selectedTab == ResourceCategory.book,
                    onTap: () =>
                        setState(() => _selectedTab = ResourceCategory.book),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ResourceTabButton(
                    label: 'الملخصات والشروحات',
                    isSelected: _selectedTab == ResourceCategory.summary,
                    onTap: () =>
                        setState(() => _selectedTab = ResourceCategory.summary),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ResourceTabButton(
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
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: ResourceItemCard(
                          resource: res,
                          isDownloaded:
                              _downloadState[res.id] ?? res.isDownloaded,
                          isLoading: _loadingState[res.id] ?? false,
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

  Color _colorFromHex(String hex) {
    final h = hex.replaceAll('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }

  IconData _iconData(String icon) => switch (icon) {
        'calculator' => Icons.calculate_outlined,
        'book' => Icons.menu_book_rounded,
        'flask' => Icons.science_outlined,
        'globe' => Icons.language_rounded,
        'landmark' => Icons.account_balance_outlined,
        'microscope' => Icons.biotech_outlined,
        _ => Icons.book_outlined,
      };

  String _levelLabel(SchoolLevel level) => switch (level) {
        SchoolLevel.primary => 'ابتدائي',
        SchoolLevel.middle => 'إعدادي',
        SchoolLevel.high => 'ثانوي',
      };

  String _branchLabel(SubjectBranch branch) => switch (branch) {
        SubjectBranch.science => 'علمي',
        SubjectBranch.arts => 'أدبي',
      };
}
