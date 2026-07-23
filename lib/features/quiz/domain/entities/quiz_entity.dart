import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  const QuestionEntity({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
  });

  final String id;
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;

  @override
  List<Object?> get props => [id, questionText, correctOptionIndex];
}

class QuizEntity extends Equatable {
  const QuizEntity({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.description,
    required this.timeLimitMinutes,
    required this.questions,
  });

  final String id;
  final String subjectId;
  final String title;
  final String description;
  final int timeLimitMinutes;
  final List<QuestionEntity> questions;

  @override
  List<Object?> get props => [id, subjectId, title, questions];
}
