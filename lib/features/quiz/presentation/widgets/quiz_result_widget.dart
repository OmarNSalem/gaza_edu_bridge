import 'package:flutter/material.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';
import 'package:gaza_edu_bridge/features/quiz/domain/entities/quiz_entity.dart';
import 'package:gaza_edu_bridge/shared/widgets/app_header.dart';

class QuizResultWidget extends StatefulWidget {
  const QuizResultWidget({
    super.key,
    required this.questions,
    required this.answers,
    required this.score,
    required this.onRetry,
    required this.onBack,
  });

  final List<QuestionEntity> questions;
  final Map<int, int> answers;
  final int score;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  State<QuizResultWidget> createState() => _QuizResultWidgetState();
}

class _QuizResultWidgetState extends State<QuizResultWidget> {
  bool _showReview = false;

  @override
  Widget build(BuildContext context) {
    final total = widget.questions.length;
    final percent = ((widget.score / total) * 100).round();
    final isPassed = percent >= 50;
    final resultColor = isPassed ? AppColors.success : AppColors.error;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(
        title: 'نتيجة الاختبار',
        subtitle: 'Quiz Result',
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: AppBorderRadius.roundedXl,
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: resultColor.withValues(alpha: 0.1),
                    border: Border.all(color: resultColor, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      '$percent%',
                      style: AppTextStyles.sectionTitle.copyWith(
                        fontSize: 28,
                        color: resultColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  isPassed ? 'أحسنت! نتيجة ممتازة' : 'حاول مرة أخرى',
                  style: AppTextStyles.cardTitle.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 4),
                Text(
                  '${widget.score} إجابة صحيحة من $total',
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _StatBadge(
                      label: 'صحيح',
                      value: '${widget.score}',
                      color: AppColors.success,
                    ),
                    _StatBadge(
                      label: 'خطأ',
                      value: '${total - widget.score}',
                      color: AppColors.error,
                    ),
                    _StatBadge(
                      label: 'المجموع',
                      value: '$total',
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => setState(() => _showReview = !_showReview),
                  icon: Icon(
                    _showReview
                        ? Icons.visibility_off_outlined
                        : Icons.fact_check_outlined,
                    size: 18,
                  ),
                  label: Text(_showReview ? 'إخفاء' : 'مراجعة الإجابات'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppBorderRadius.roundedLg,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: widget.onRetry,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text('إعادة'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppBorderRadius.roundedLg,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_showReview) ...[
            const SizedBox(height: AppSpacing.lg),
            Text('مراجعة الإجابات:', style: AppTextStyles.cardTitle),
            const SizedBox(height: AppSpacing.md),
            ...List.generate(widget.questions.length, (i) {
              final q = widget.questions[i];
              final userAns = widget.answers[i];
              final isCorrect = userAns == q.correctOptionIndex;

              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: AppBorderRadius.roundedXl,
                    border: Border.all(
                      color: isCorrect ? AppColors.success : AppColors.error,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isCorrect
                                ? Icons.check_circle_outline
                                : Icons.cancel_outlined,
                            color: isCorrect ? AppColors.success : AppColors.error,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'س${i + 1}: ${q.questionText}',
                              style: AppTextStyles.bodyMedium
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'إجابتك: ${userAns != null ? q.options[userAns] : "لم تجب"}',
                        style: AppTextStyles.badgeText.copyWith(
                          color: isCorrect ? AppColors.success : AppColors.error,
                          fontSize: 12,
                        ),
                      ),
                      if (!isCorrect) ...[
                        Text(
                          'الصحيحة: ${q.options[q.correctOptionIndex]}',
                          style: AppTextStyles.badgeText
                              .copyWith(color: AppColors.success, fontSize: 12),
                        ),
                      ],
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: AppBorderRadius.roundedSm,
                        ),
                        child: Text(
                          'التوضيح: ${q.explanation}',
                          style: AppTextStyles.badgeText
                              .copyWith(fontSize: 11, color: AppColors.mutedText),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
          const SizedBox(height: AppSpacing.md),
          Center(
            child: TextButton(
              onPressed: widget.onBack,
              child: Text(
                'العودة لإعداد الاختبار',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  const _StatBadge({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: AppBorderRadius.roundedLg,
          ),
          child: Text(
            value,
            style: AppTextStyles.cardTitle.copyWith(color: color, fontSize: 20),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.badgeText),
      ],
    );
  }
}
