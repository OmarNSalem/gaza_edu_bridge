import 'package:gaza_edu_bridge/features/subjects/domain/entities/subject_entity.dart';
import 'package:gaza_edu_bridge/features/resources/domain/entities/resource_entity.dart';
import 'package:gaza_edu_bridge/features/quiz/domain/entities/quiz_entity.dart';

class MockData {
  // قائمة الاختبارات التجريبية
  static const List<QuizEntity> quizzes = [
    QuizEntity(
      id: 'quiz-math-12',
      subjectId: 'math-h12-sci',
      title: 'اختبار الرياضيات التفاعلي - وحدة التفاضل',
      description: 'اختبار تقييمي قصير يغطي قواعد المشتقات والتكامل وتطبيقاتها.',
      timeLimitMinutes: 10,
      questions: [
        QuestionEntity(
          id: 'q1',
          questionText: 'ما هي مشتقة الدالة f(x) = x³ + 4x؟',
          options: ['3x² + 4', '3x + 4', 'x² + 4', '3x²'],
          correctOptionIndex: 0,
          explanation: 'مشتقة x³ هي 3x² ومشتقة 4x هي 4، فتكون المشتقة 3x² + 4.',
        ),
        QuestionEntity(
          id: 'q2',
          questionText: 'ما قيمة تكامل ∫ (2x + 1) dx؟',
          options: ['x² + x + C', '2x² + C', 'x² + C', '2x + C'],
          correctOptionIndex: 0,
          explanation: 'تكامل 2x هو x² وتكامل 1 هو x، مع الثابت C.',
        ),
        QuestionEntity(
          id: 'q3',
          questionText: 'إذا كان f(x) = sin(x)، فإن المشتقة الثانية f\'\'(x) هي:',
          options: ['-sin(x)', 'cos(x)', '-cos(x)', 'sin(x)'],
          correctOptionIndex: 0,
          explanation: 'المشتقة الأولى هي cos(x) والمشتقة الثانية هي -sin(x).',
        ),
        QuestionEntity(
          id: 'q4',
          questionText: 'ما هو الميل عند النقطة (1, 3) للدالة y = 3x²؟',
          options: ['6', '3', '2', '9'],
          correctOptionIndex: 0,
          explanation: 'المشتقة dy/dx = 6x، وعند x=1 يكون الميل = 6(1) = 6.',
        ),
      ],
    ),
    QuizEntity(
      id: 'quiz-physics-12',
      subjectId: 'physics-h12-sci',
      title: 'اختبار الفيزياء - قوانين النيوتن والميكانيكا',
      description: 'اختبار شامل لقوانين الحركة والديناميكا.',
      timeLimitMinutes: 8,
      questions: [
        QuestionEntity(
          id: 'pq1',
          questionText: 'وحدة قياس القوة في النظام الدولي هي:',
          options: ['النيوتن (N)', 'الجول (J)', 'الواط (W)', 'الباسكال (Pa)'],
          correctOptionIndex: 0,
          explanation: 'القوة تُقاس بالنيوتن وتساوي kg·m/s².',
        ),
        QuestionEntity(
          id: 'pq2',
          questionText: 'ينص قانون نيوتن الثاني على أن القوة تساوي:',
          options: ['الكتلة × التسارع (F = m·a)', 'السرعة × الزمن', 'الكتلة / التسارع', 'الشغل / الزمن'],
          correctOptionIndex: 0,
          explanation: 'القوة الناتجة الفعالة تساوي حاصل ضرب الكتلة في التسارع m·a.',
        ),
      ],
    ),
  ];
  // قائمة الموارد والملفات التعليمية للمواد
  static final List<ResourceEntity> resources = [
    // ── رياضيات توجيهي علمي (math-h12-sci) ──
    const ResourceEntity(
      id: 'res-1',
      subjectId: 'math-h12-sci',
      title: 'كتاب الرياضيات - الجزء الأول (الوزاري)',
      description: 'الكتاب المدرسي المعتمد لوزارة التربية والتعليم للفرع العلمي - الفصل الدراسي الأول.',
      category: ResourceCategory.book,
      fileSizeMb: 14.2,
      pageCount: 180,
      downloadUrl: 'https://example.com/math1.pdf',
    ),
    const ResourceEntity(
      id: 'res-2',
      subjectId: 'math-h12-sci',
      title: 'ملخص وحلول وحدة التفاضل والتكامل',
      description: 'شرح مفصل بالأمثلة والحلول النموذجية لجميع تمارين وحدة التفاضل.',
      category: ResourceCategory.summary,
      fileSizeMb: 5.8,
      pageCount: 45,
      downloadUrl: 'https://example.com/math_summary.pdf',
    ),
    const ResourceEntity(
      id: 'res-3',
      subjectId: 'math-h12-sci',
      title: 'امتحانات توجيهي سنوات سابقة (2020 - 2024)',
      description: 'تجميعة الامتحانات الوزارية مع مفاتيح الإجابات المعتمدة من لجنة التصحيح.',
      category: ResourceCategory.exam,
      fileSizeMb: 8.4,
      pageCount: 62,
      downloadUrl: 'https://example.com/math_exams.pdf',
    ),

    // ── فيزياء توجيهي علمي (physics-h12-sci) ──
    const ResourceEntity(
      id: 'res-4',
      subjectId: 'physics-h12-sci',
      title: 'كتاب الفيزياء الوزاري - توجيهي',
      description: 'الكتاب المعتمد شاملاً فصول الميكانيكا والكهرباء والمغناطيسية.',
      category: ResourceCategory.book,
      fileSizeMb: 16.5,
      pageCount: 210,
      downloadUrl: 'https://example.com/physics_book.pdf',
    ),
    const ResourceEntity(
      id: 'res-5',
      subjectId: 'physics-h12-sci',
      title: 'كراسة التفوق في الفيزياء (قوانين وملخصات)',
      description: 'تجميع قوانين الفيزياء كاملة مع أسئلة وإجابات نموذجية.',
      category: ResourceCategory.summary,
      fileSizeMb: 4.2,
      pageCount: 38,
      downloadUrl: 'https://example.com/physics_summary.pdf',
    ),

    // ── كيمياء توجيهي علمي (chemistry-h12-sci) ──
    const ResourceEntity(
      id: 'res-6',
      subjectId: 'chemistry-h12-sci',
      title: 'كتاب الكيمياء الوزاري الكامل',
      description: 'شرح الكيمياء العامة والحرارية والعضوية التوجيهي العلمي.',
      category: ResourceCategory.book,
      fileSizeMb: 12.0,
      pageCount: 165,
      downloadUrl: 'https://example.com/chem_book.pdf',
    ),
    const ResourceEntity(
      id: 'res-7',
      subjectId: 'chemistry-h12-sci',
      title: 'اختبارات قصيرة ومراجعة الشاملة',
      description: 'أسئلة اختيار من متعدد واختبارات مع الحلول النموذجية.',
      category: ResourceCategory.exam,
      fileSizeMb: 3.5,
      pageCount: 28,
      downloadUrl: 'https://example.com/chem_exams.pdf',
    ),
  ];

  // قائمة المواد الدراسية المصدرية الشاملة لكل الصفوف
  static const List<SubjectEntity> subjects = [
    // ── 1. الابتدائي (صف 1 - 6) ──
    // صف 1
    SubjectEntity(id: 'math-p1', name: 'الرياضيات', nameEn: 'Mathematics', level: SchoolLevel.primary, grade: 1, icon: 'calculator', colorHex: '#1A1A1A', resourceCount: 5),
    SubjectEntity(id: 'arabic-p1', name: 'اللغة العربية (لغتنا الجميلة)', nameEn: 'Arabic', level: SchoolLevel.primary, grade: 1, icon: 'book', colorHex: '#7C3AED', resourceCount: 4),
    SubjectEntity(id: 'islamic-p1', name: 'التربية الإسلامية', nameEn: 'Islamic Education', level: SchoolLevel.primary, grade: 1, icon: 'landmark', colorHex: '#10B981', resourceCount: 3),
    SubjectEntity(id: 'sci-p1', name: 'التنشئة العلمية والوطنية', nameEn: 'Science & National Education', level: SchoolLevel.primary, grade: 1, icon: 'globe', colorHex: '#1F6FEB', resourceCount: 3),

    // صف 2
    SubjectEntity(id: 'math-p2', name: 'الرياضيات', nameEn: 'Mathematics', level: SchoolLevel.primary, grade: 2, icon: 'calculator', colorHex: '#1A1A1A', resourceCount: 5),
    SubjectEntity(id: 'arabic-p2', name: 'اللغة العربية', nameEn: 'Arabic', level: SchoolLevel.primary, grade: 2, icon: 'book', colorHex: '#7C3AED', resourceCount: 4),
    SubjectEntity(id: 'islamic-p2', name: 'التربية الإسلامية', nameEn: 'Islamic Education', level: SchoolLevel.primary, grade: 2, icon: 'landmark', colorHex: '#10B981', resourceCount: 3),
    SubjectEntity(id: 'sci-p2', name: 'التنشئة العلمية', nameEn: 'Science', level: SchoolLevel.primary, grade: 2, icon: 'flask', colorHex: '#1F6FEB', resourceCount: 4),

    // صف 3
    SubjectEntity(id: 'math-p3', name: 'الرياضيات', nameEn: 'Mathematics', level: SchoolLevel.primary, grade: 3, icon: 'calculator', colorHex: '#1A1A1A', resourceCount: 6),
    SubjectEntity(id: 'arabic-p3', name: 'اللغة العربية', nameEn: 'Arabic', level: SchoolLevel.primary, grade: 3, icon: 'book', colorHex: '#7C3AED', resourceCount: 5),
    SubjectEntity(id: 'english-p3', name: 'اللغة الإنجليزية', nameEn: 'English', level: SchoolLevel.primary, grade: 3, icon: 'globe', colorHex: '#F0883E', resourceCount: 4),
    SubjectEntity(id: 'sci-p3', name: 'العلوم والحياة', nameEn: 'Science & Life', level: SchoolLevel.primary, grade: 3, icon: 'flask', colorHex: '#1F6FEB', resourceCount: 4),

    // صف 4
    SubjectEntity(id: 'math-p4', name: 'الرياضيات', nameEn: 'Mathematics', level: SchoolLevel.primary, grade: 4, icon: 'calculator', colorHex: '#1A1A1A', resourceCount: 6),
    SubjectEntity(id: 'arabic-p4', name: 'اللغة العربية', nameEn: 'Arabic', level: SchoolLevel.primary, grade: 4, icon: 'book', colorHex: '#7C3AED', resourceCount: 5),
    SubjectEntity(id: 'english-p4', name: 'اللغة الإنجليزية', nameEn: 'English', level: SchoolLevel.primary, grade: 4, icon: 'globe', colorHex: '#F0883E', resourceCount: 4),
    SubjectEntity(id: 'sci-p4', name: 'العلوم والحياة', nameEn: 'Science & Life', level: SchoolLevel.primary, grade: 4, icon: 'flask', colorHex: '#1F6FEB', resourceCount: 5),
    SubjectEntity(id: 'social-p4', name: 'الدراسات الاجتماعية', nameEn: 'Social Studies', level: SchoolLevel.primary, grade: 4, icon: 'landmark', colorHex: '#E3B341', resourceCount: 3),

    // صف 5
    SubjectEntity(id: 'math-p5', name: 'الرياضيات', nameEn: 'Mathematics', level: SchoolLevel.primary, grade: 5, icon: 'calculator', colorHex: '#1A1A1A', resourceCount: 7),
    SubjectEntity(id: 'arabic-p5', name: 'اللغة العربية', nameEn: 'Arabic', level: SchoolLevel.primary, grade: 5, icon: 'book', colorHex: '#7C3AED', resourceCount: 6),
    SubjectEntity(id: 'english-p5', name: 'اللغة الإنجليزية', nameEn: 'English', level: SchoolLevel.primary, grade: 5, icon: 'globe', colorHex: '#F0883E', resourceCount: 5),
    SubjectEntity(id: 'sci-p5', name: 'العلوم والحياة', nameEn: 'Science & Life', level: SchoolLevel.primary, grade: 5, icon: 'flask', colorHex: '#1F6FEB', resourceCount: 6),
    SubjectEntity(id: 'social-p5', name: 'الدراسات الاجتماعية', nameEn: 'Social Studies', level: SchoolLevel.primary, grade: 5, icon: 'landmark', colorHex: '#E3B341', resourceCount: 4),

    // صف 6
    SubjectEntity(id: 'math-p6', name: 'الرياضيات', nameEn: 'Mathematics', level: SchoolLevel.primary, grade: 6, icon: 'calculator', colorHex: '#1A1A1A', resourceCount: 8),
    SubjectEntity(id: 'arabic-p6', name: 'اللغة العربية', nameEn: 'Arabic', level: SchoolLevel.primary, grade: 6, icon: 'book', colorHex: '#7C3AED', resourceCount: 6),
    SubjectEntity(id: 'english-p6', name: 'اللغة الإنجليزية', nameEn: 'English', level: SchoolLevel.primary, grade: 6, icon: 'globe', colorHex: '#F0883E', resourceCount: 5),
    SubjectEntity(id: 'sci-p6', name: 'العلوم والحياة', nameEn: 'Science & Life', level: SchoolLevel.primary, grade: 6, icon: 'flask', colorHex: '#1F6FEB', resourceCount: 6),

    // ── 2. الإعدادي (صف 7 - 9) ──
    // صف 7
    SubjectEntity(id: 'math-m7', name: 'الرياضيات', nameEn: 'Mathematics', level: SchoolLevel.middle, grade: 7, icon: 'calculator', colorHex: '#1A1A1A', resourceCount: 8),
    SubjectEntity(id: 'arabic-m7', name: 'اللغة العربية', nameEn: 'Arabic', level: SchoolLevel.middle, grade: 7, icon: 'book', colorHex: '#7C3AED', resourceCount: 6),
    SubjectEntity(id: 'sci-m7', name: 'العلوم والحياة', nameEn: 'Science & Life', level: SchoolLevel.middle, grade: 7, icon: 'flask', colorHex: '#1F6FEB', resourceCount: 7),
    SubjectEntity(id: 'english-m7', name: 'اللغة الإنجليزية', nameEn: 'English', level: SchoolLevel.middle, grade: 7, icon: 'globe', colorHex: '#F0883E', resourceCount: 5),

    // صف 8
    SubjectEntity(id: 'math-m8', name: 'الرياضيات', nameEn: 'Mathematics', level: SchoolLevel.middle, grade: 8, icon: 'calculator', colorHex: '#1A1A1A', resourceCount: 9),
    SubjectEntity(id: 'arabic-m8', name: 'اللغة العربية', nameEn: 'Arabic', level: SchoolLevel.middle, grade: 8, icon: 'book', colorHex: '#7C3AED', resourceCount: 7),
    SubjectEntity(id: 'sci-m8', name: 'العلوم والحياة', nameEn: 'Science & Life', level: SchoolLevel.middle, grade: 8, icon: 'flask', colorHex: '#1F6FEB', resourceCount: 8),
    SubjectEntity(id: 'english-m8', name: 'اللغة الإنجليزية', nameEn: 'English', level: SchoolLevel.middle, grade: 8, icon: 'globe', colorHex: '#F0883E', resourceCount: 6),

    // صف 9
    SubjectEntity(id: 'math-m9', name: 'الرياضيات', nameEn: 'Mathematics', level: SchoolLevel.middle, grade: 9, icon: 'calculator', colorHex: '#1A1A1A', resourceCount: 10),
    SubjectEntity(id: 'arabic-m9', name: 'اللغة العربية', nameEn: 'Arabic', level: SchoolLevel.middle, grade: 9, icon: 'book', colorHex: '#7C3AED', resourceCount: 8),
    SubjectEntity(id: 'sci-m9', name: 'العلوم والحياة', nameEn: 'Science & Life', level: SchoolLevel.middle, grade: 9, icon: 'flask', colorHex: '#1F6FEB', resourceCount: 9),
    SubjectEntity(id: 'english-m9', name: 'اللغة الإنجليزية', nameEn: 'English', level: SchoolLevel.middle, grade: 9, icon: 'globe', colorHex: '#F0883E', resourceCount: 7),

    // ── 3. الثانوي (صف 10 - 12) ──
    // صف 10
    SubjectEntity(id: 'math-h10', name: 'الرياضيات', nameEn: 'Mathematics', level: SchoolLevel.high, grade: 10, icon: 'calculator', colorHex: '#1A1A1A', resourceCount: 10),
    SubjectEntity(id: 'physics-h10', name: 'الفيزياء', nameEn: 'Physics', level: SchoolLevel.high, grade: 10, icon: 'flask', colorHex: '#1F6FEB', resourceCount: 8),
    SubjectEntity(id: 'chemistry-h10', name: 'الكيمياء', nameEn: 'Chemistry', level: SchoolLevel.high, grade: 10, icon: 'microscope', colorHex: '#EF4444', resourceCount: 7),
    SubjectEntity(id: 'arabic-h10', name: 'اللغة العربية', nameEn: 'Arabic', level: SchoolLevel.high, grade: 10, icon: 'book', colorHex: '#7C3AED', resourceCount: 7),
    SubjectEntity(id: 'english-h10', name: 'اللغة الإنجليزية', nameEn: 'English', level: SchoolLevel.high, grade: 10, icon: 'globe', colorHex: '#F0883E', resourceCount: 6),

    // صف 11 - علمي
    SubjectEntity(id: 'math-h11-sci', name: 'الرياضيات (علمي)', nameEn: 'Mathematics (Science)', level: SchoolLevel.high, grade: 11, branch: SubjectBranch.science, icon: 'calculator', colorHex: '#1A1A1A', resourceCount: 12),
    SubjectEntity(id: 'physics-h11-sci', name: 'الفيزياء', nameEn: 'Physics', level: SchoolLevel.high, grade: 11, branch: SubjectBranch.science, icon: 'flask', colorHex: '#1F6FEB', resourceCount: 10),
    SubjectEntity(id: 'chemistry-h11-sci', name: 'الكيمياء', nameEn: 'Chemistry', level: SchoolLevel.high, grade: 11, branch: SubjectBranch.science, icon: 'microscope', colorHex: '#EF4444', resourceCount: 9),
    SubjectEntity(id: 'bio-h11-sci', name: 'العلوم الحياتية', nameEn: 'Biology', level: SchoolLevel.high, grade: 11, branch: SubjectBranch.science, icon: 'flask', colorHex: '#10B981', resourceCount: 8),

    // صف 11 - أدبي
    SubjectEntity(id: 'arabic-h11-arts', name: 'اللغة العربية (أدبي)', nameEn: 'Arabic Literature', level: SchoolLevel.high, grade: 11, branch: SubjectBranch.arts, icon: 'book', colorHex: '#7C3AED', resourceCount: 9),
    SubjectEntity(id: 'history-h11-arts', name: 'التاريخ', nameEn: 'History', level: SchoolLevel.high, grade: 11, branch: SubjectBranch.arts, icon: 'landmark', colorHex: '#E3B341', resourceCount: 7),
    SubjectEntity(id: 'geography-h11-arts', name: 'الجغرافيا', nameEn: 'Geography', level: SchoolLevel.high, grade: 11, branch: SubjectBranch.arts, icon: 'globe', colorHex: '#F0883E', resourceCount: 6),
    SubjectEntity(id: 'math-h11-arts', name: 'الرياضيات (أدبي)', nameEn: 'Mathematics (Literary)', level: SchoolLevel.high, grade: 11, branch: SubjectBranch.arts, icon: 'calculator', colorHex: '#1A1A1A', resourceCount: 5),

    // صف 12 - علمي (توجيهي علمي)
    SubjectEntity(id: 'math-h12-sci', name: 'الرياضيات (توجيهي علمي)', nameEn: 'Advanced Mathematics', level: SchoolLevel.high, grade: 12, branch: SubjectBranch.science, icon: 'calculator', colorHex: '#1A1A1A', resourceCount: 15),
    SubjectEntity(id: 'physics-h12-sci', name: 'الفيزياء (توجيهي)', nameEn: 'Advanced Physics', level: SchoolLevel.high, grade: 12, branch: SubjectBranch.science, icon: 'flask', colorHex: '#1F6FEB', resourceCount: 14),
    SubjectEntity(id: 'chemistry-h12-sci', name: 'الكيمياء (توجيهي)', nameEn: 'Advanced Chemistry', level: SchoolLevel.high, grade: 12, branch: SubjectBranch.science, icon: 'microscope', colorHex: '#EF4444', resourceCount: 12),
    SubjectEntity(id: 'bio-h12-sci', name: 'العلوم الحياتية (توجيهي)', nameEn: 'Advanced Biology', level: SchoolLevel.high, grade: 12, branch: SubjectBranch.science, icon: 'flask', colorHex: '#10B981', resourceCount: 11),

    // صف 12 - أدبي (توجيهي أدبي)
    SubjectEntity(id: 'arabic-h12-arts', name: 'اللغة العربية (توجيهي)', nameEn: 'Arabic Literature', level: SchoolLevel.high, grade: 12, branch: SubjectBranch.arts, icon: 'book', colorHex: '#7C3AED', resourceCount: 14),
    SubjectEntity(id: 'history-h12-arts', name: 'التاريخ المعاصر (توجيهي)', nameEn: 'Modern History', level: SchoolLevel.high, grade: 12, branch: SubjectBranch.arts, icon: 'landmark', colorHex: '#E3B341', resourceCount: 12),
    SubjectEntity(id: 'geography-h12-arts', name: 'الجغرافيا (توجيهي)', nameEn: 'Advanced Geography', level: SchoolLevel.high, grade: 12, branch: SubjectBranch.arts, icon: 'globe', colorHex: '#F0883E', resourceCount: 10),
  ];
}
