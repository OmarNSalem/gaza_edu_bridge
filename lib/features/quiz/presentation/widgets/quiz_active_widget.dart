import 'package:flutter/material.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';
import 'package:gaza_edu_bridge/features/quiz/domain/entities/quiz_entity.dart';
import 'package:gaza_edu_bridge/shared/widgets/app_header.dart';

class QuizActiveWidget extends StatelessWidget {
  const QuizActiveWidget({
    super.key,
    required this.questions,
    required this.currentIndex,
    required this.answers,
    required this.onSelect,
    required this.onNext,
    required this.onPrevious,
    required this.onExit,
  });

  final List<QuestionEntity> questions;
  final int currentIndex;
  final Map<int, int> answers;
  final ValueChanged<int> onSelect;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];
    final selectedOption = answers[currentIndex];
    final isLast = currentIndex == questions.length - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'الاختبار',
        subtitle: 'السؤال ${currentIndex + 1} من ${questions.length}',
        showBack: true,
        onBack: onExit,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.lg),
          child: Row(
            children: [
              if (currentIndex > 0) ...[
                Expanded(
                  child: OutlinedButton(
                    onPressed: onPrevious,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppBorderRadius.roundedLg,
                      ),
                    ),
                    child: Text(
                      'السابق',
                      style: AppTextStyles.buttonText
                          .copyWith(color: AppColors.foregroundText),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
              ],
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: selectedOption != null ? onNext : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        AppColors.primary.withValues(alpha: 0.3),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppBorderRadius.roundedLg,
                    ),
                  ),
                  child: Text(
                    isLast ? 'إنهاء الاختبار' : 'السؤال التالي',
                    style: AppTextStyles.buttonText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: (currentIndex + 1) / questions.length,
                            backgroundColor: AppColors.secondary,
                            color: AppColors.primary,
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        '${currentIndex + 1}/${questions.length}',
                        style: AppTextStyles.badgeText.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: AppBorderRadius.roundedXl,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      question.questionText,
                      style: AppTextStyles.cardTitle.copyWith(
                        fontSize: 17,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'اختر الإجابة الصحيحة:',
                    style: AppTextStyles.badgeText
                        .copyWith(color: AppColors.mutedText),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final isSelected = selectedOption == i;
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    0,
                    AppSpacing.lg,
                    i == question.options.length - 1
                        ? AppSpacing.xl
                        : AppSpacing.sm,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: AppBorderRadius.roundedXl,
                    child: InkWell(
                      borderRadius: AppBorderRadius.roundedXl,
                      onTap: () => onSelect(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md, vertical: 14),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.cardBg,
                          borderRadius: AppBorderRadius.roundedXl,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? Colors.white.withValues(alpha: 0.2)
                                    : AppColors.secondary,
                              ),
                              child: Center(
                                child: Text(
                                  _sym(i),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.foregroundText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Text(
                                question.options[i],
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.foregroundText,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                            if (isSelected)
                              const Icon(Icons.check_circle_rounded,
                                  color: Colors.white, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: question.options.length,
            ),
          ),
        ],
      ),
    );
  }

  String _sym(int i) => switch (i) {
        0 => 'أ',
        1 => 'ب',
        2 => 'ج',
        3 => 'د',
        _ => '${i + 1}',
      };
}
