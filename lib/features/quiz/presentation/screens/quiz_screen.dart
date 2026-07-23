import 'package:flutter/material.dart';
import 'package:gaza_edu_bridge/core/utils/mock_data.dart';
import 'package:gaza_edu_bridge/features/quiz/domain/entities/quiz_entity.dart';
import 'package:gaza_edu_bridge/features/subjects/domain/entities/subject_entity.dart';
import '../widgets/quiz_setup_widget.dart';
import '../widgets/quiz_active_widget.dart';
import '../widgets/quiz_result_widget.dart';

enum _QuizPhase { setup, active, result }

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  _QuizPhase _phase = _QuizPhase.setup;
  SchoolLevel? _selectedLevel;
  int? _selectedGrade;
  String? _selectedSubjectId;
  int _selectedQuestionCount = 5;

  List<QuestionEntity> _activeQuestions = [];
  int _currentIndex = 0;
  final Map<int, int> _answers = {};

  List<int> get _grades {
    if (_selectedLevel == null) return [];
    return switch (_selectedLevel!) {
      SchoolLevel.primary => [1, 2, 3, 4, 5, 6],
      SchoolLevel.middle => [7, 8, 9],
      SchoolLevel.high => [10, 11, 12],
    };
  }

  List<SubjectEntity> get _availableSubjects {
    if (_selectedLevel == null || _selectedGrade == null) return [];
    return MockData.subjects
        .where((s) => s.level == _selectedLevel && s.grade == _selectedGrade)
        .toList();
  }

  List<int> get _questionCountOptions {
    if (_selectedSubjectId == null) return [5, 10];
    final quiz = MockData.quizzes
        .where((q) => q.subjectId == _selectedSubjectId)
        .toList();
    if (quiz.isEmpty) return [5];
    final maxQ = quiz.first.questions.length;
    final opts = <int>[];
    for (final n in [3, 5, 10]) {
      if (n <= maxQ) opts.add(n);
    }
    if (opts.isEmpty) opts.add(maxQ);
    return opts;
  }

  bool get _canStart =>
      _selectedLevel != null &&
      _selectedGrade != null &&
      _selectedSubjectId != null;

  void _startQuiz() {
    final quiz = MockData.quizzes
        .where((q) => q.subjectId == _selectedSubjectId)
        .toList();

    if (quiz.isEmpty) {
      final fallback = MockData.quizzes.isNotEmpty
          ? MockData.quizzes.first.questions
          : <QuestionEntity>[];
      _activeQuestions = (fallback.toList()..shuffle())
          .take(_selectedQuestionCount)
          .toList();
    } else {
      final questions = quiz.first.questions.toList()..shuffle();
      _activeQuestions = questions.take(_selectedQuestionCount).toList();
    }

    setState(() {
      _currentIndex = 0;
      _answers.clear();
      _phase = _QuizPhase.active;
    });
  }

  void _selectOption(int optionIndex) {
    setState(() => _answers[_currentIndex] = optionIndex);
  }

  void _goNext() {
    if (_currentIndex < _activeQuestions.length - 1) {
      setState(() => _currentIndex++);
    } else {
      setState(() => _phase = _QuizPhase.result);
    }
  }

  void _goPrevious() {
    if (_currentIndex > 0) setState(() => _currentIndex--);
  }

  int get _score {
    int c = 0;
    for (int i = 0; i < _activeQuestions.length; i++) {
      if (_answers[i] == _activeQuestions[i].correctOptionIndex) c++;
    }
    return c;
  }

  void _resetToSetup() {
    setState(() {
      _phase = _QuizPhase.setup;
      _answers.clear();
      _currentIndex = 0;
      _activeQuestions = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return switch (_phase) {
      _QuizPhase.setup => QuizSetupWidget(
          selectedLevel: _selectedLevel,
          selectedGrade: _selectedGrade,
          selectedSubjectId: _selectedSubjectId,
          selectedQuestionCount: _selectedQuestionCount,
          grades: _grades,
          availableSubjects: _availableSubjects,
          questionCountOptions: _questionCountOptions,
          canStart: _canStart,
          onLevelChanged: (level) => setState(() {
            _selectedLevel = level;
            _selectedGrade = null;
            _selectedSubjectId = null;
            _selectedQuestionCount = 5;
          }),
          onGradeChanged: (grade) => setState(() {
            _selectedGrade = grade;
            _selectedSubjectId = null;
            _selectedQuestionCount = 5;
          }),
          onSubjectChanged: (id) => setState(() {
            _selectedSubjectId = id;
            _selectedQuestionCount = _questionCountOptions.first;
          }),
          onQuestionCountChanged: (n) =>
              setState(() => _selectedQuestionCount = n),
          onStart: _startQuiz,
        ),
      _QuizPhase.active => QuizActiveWidget(
          questions: _activeQuestions,
          currentIndex: _currentIndex,
          answers: _answers,
          onSelect: _selectOption,
          onNext: _goNext,
          onPrevious: _goPrevious,
          onExit: _resetToSetup,
        ),
      _QuizPhase.result => QuizResultWidget(
          questions: _activeQuestions,
          answers: _answers,
          score: _score,
          onRetry: _startQuiz,
          onBack: _resetToSetup,
        ),
    };
  }
}
