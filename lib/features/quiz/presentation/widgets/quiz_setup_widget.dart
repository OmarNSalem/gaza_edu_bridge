import 'package:flutter/material.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';
import 'package:gaza_edu_bridge/features/subjects/domain/entities/subject_entity.dart';
import 'package:gaza_edu_bridge/shared/widgets/app_header.dart';
import 'quiz_dropdown_field.dart';

class QuizSetupWidget extends StatelessWidget {
  const QuizSetupWidget({
    super.key,
    required this.selectedLevel,
    required this.selectedGrade,
    required this.selectedSubjectId,
    required this.selectedQuestionCount,
    required this.grades,
    required this.availableSubjects,
    required this.questionCountOptions,
    required this.canStart,
    required this.onLevelChanged,
    required this.onGradeChanged,
    required this.onSubjectChanged,
    required this.onQuestionCountChanged,
    required this.onStart,
  });

  final SchoolLevel? selectedLevel;
  final int? selectedGrade;
  final String? selectedSubjectId;
  final int selectedQuestionCount;
  final List<int> grades;
  final List<SubjectEntity> availableSubjects;
  final List<int> questionCountOptions;
  final bool canStart;
  final ValueChanged<SchoolLevel?> onLevelChanged;
  final ValueChanged<int?> onGradeChanged;
  final ValueChanged<String?> onSubjectChanged;
  final ValueChanged<int> onQuestionCountChanged;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(
        title: 'الاختبار',
        subtitle: 'Quiz',
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'إعداد الاختبار',
                    style: AppTextStyles.sectionTitle.copyWith(fontSize: 22),
                  ),
                  Text(
                    'Quiz Setup',
                    style: AppTextStyles.bodySmall.copyWith(fontSize: 13),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── بطاقة الإعداد ──
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: AppBorderRadius.roundedXl,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        // 1. المرحلة الدراسية
                        QuizDropdownField<SchoolLevel>(
                          label: 'المرحلة الدراسية',
                          value: selectedLevel,
                          hint: 'اختر المرحلة',
                          items: const [
                            DropdownMenuItem(
                              value: SchoolLevel.primary,
                              child: Text('الابتدائية'),
                            ),
                            DropdownMenuItem(
                              value: SchoolLevel.middle,
                              child: Text('الإعدادية'),
                            ),
                            DropdownMenuItem(
                              value: SchoolLevel.high,
                              child: Text('الثانوية'),
                            ),
                          ],
                          onChanged: onLevelChanged,
                        ),

                        // 2. السنة الدراسية
                        QuizDropdownField<int>(
                          label: 'السنة الدراسية',
                          value: selectedGrade,
                          hint: selectedLevel == null
                              ? 'اختر المرحلة أولاً'
                              : 'اختر الصف',
                          enabled: grades.isNotEmpty,
                          items: grades
                              .map((g) => DropdownMenuItem(
                                    value: g,
                                    child: Text('الصف $g'),
                                  ))
                              .toList(),
                          onChanged: onGradeChanged,
                        ),

                        // 3. المادة
                        QuizDropdownField<String>(
                          label: 'المادة',
                          value: selectedSubjectId,
                          hint: selectedGrade == null
                              ? 'اختر الصف أولاً'
                              : 'اختر المادة',
                          enabled: availableSubjects.isNotEmpty,
                          items: availableSubjects
                              .map((s) => DropdownMenuItem(
                                    value: s.id,
                                    child: Text(s.name),
                                  ))
                              .toList(),
                          onChanged: onSubjectChanged,
                        ),

                        // 4. عدد الأسئلة
                        QuizDropdownField<int>(
                          label: 'عدد الأسئلة',
                          value: selectedSubjectId == null
                              ? null
                              : selectedQuestionCount,
                          hint: selectedSubjectId == null
                              ? 'اختر المادة أولاً'
                              : 'عدد الأسئلة',
                          enabled: selectedSubjectId != null,
                          items: questionCountOptions
                              .map((n) => DropdownMenuItem(
                                    value: n,
                                    child: Text('$n أسئلة'),
                                  ))
                              .toList(),
                          onChanged: (n) {
                            if (n != null) onQuestionCountChanged(n);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── زر ابدأ الاختبار ──
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.xl),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: canStart ? onStart : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor:
                      AppColors.primary.withValues(alpha: 0.3),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.roundedXl,
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.assignment_outlined, size: 20),
                label: Text(
                  'ابدأ الاختبار',
                  style: AppTextStyles.buttonText.copyWith(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
