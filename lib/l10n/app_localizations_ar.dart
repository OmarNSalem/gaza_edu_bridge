// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'GazaEdu Bridge';

  @override
  String get appTagline => 'منصة غزة للتعلم الذاتي';

  @override
  String get university => 'جامعة فلسطين — 2025/2026';

  @override
  String get skip => 'تخطي';

  @override
  String get next => 'التالي';

  @override
  String get startNow => 'ابدأ الآن';

  @override
  String get back => 'رجوع';

  @override
  String get open => 'فتح';

  @override
  String get download => 'تنزيل';

  @override
  String get delete => 'حذف';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get logout => 'خروج';

  @override
  String get onboarding1Title => 'تعلّم بدون إنترنت';

  @override
  String get onboarding1TitleEn => 'Learn Offline';

  @override
  String get onboarding1Body =>
      'نزّل المواد مرة واحدة واستمر في التعلم حتى بدون اتصال بالإنترنت.';

  @override
  String get onboarding2Title => 'حمّل ملفاتك بسهولة';

  @override
  String get onboarding2TitleEn => 'Easy Downloads';

  @override
  String get onboarding2Body =>
      'ملفات PDF منظمة حسب المرحلة والصف، بأحجام صغيرة وجاهزة للقراءة في أي وقت.';

  @override
  String get welcome => 'مرحباً بك';

  @override
  String get continueWithGoogle => 'متابعة بحساب Google';

  @override
  String get login => 'تسجيل دخول';

  @override
  String get register => 'إنشاء حساب';

  @override
  String get continueAsGuest => 'متابعة كضيف';

  @override
  String get guestNote => 'بدون تسجيل — مؤقت';

  @override
  String get orContinueWithout => 'أو تابع بدون حساب';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get createNewAccount => 'إنشاء حساب جديد';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟ ';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟ ';

  @override
  String get createAccount => 'إنشاء الحساب';

  @override
  String get home => 'الرئيسية';

  @override
  String get browse => 'التصفح';

  @override
  String get quizzes => 'اختبارات';

  @override
  String get downloads => 'تنزيلات';

  @override
  String get levelPrimary => 'ابتدائي';

  @override
  String get levelMiddle => 'إعدادي';

  @override
  String get levelHigh => 'ثانوي';

  @override
  String get levelAll => 'الكل';

  @override
  String gradeLabel(int grade) {
    return 'صف $grade';
  }

  @override
  String get branchScience => 'علمي';

  @override
  String get branchArts => 'أدبي';

  @override
  String get searchHint => 'ابحث عن مادة...';

  @override
  String get noSubjectsFound => 'لا توجد مواد مطابقة للبحث';

  @override
  String files(int count) {
    return '$count ملف';
  }

  @override
  String get typeSummary => 'ملخص';

  @override
  String get typeExplanation => 'شرح';

  @override
  String get typeExercises => 'تمارين';

  @override
  String get downloadedNote => 'تم التنزيل';

  @override
  String get downloadingNote => 'جاري التنزيل...';

  @override
  String get deleteDownload => 'حذف التنزيل';

  @override
  String get totalStorage => 'إجمالي المساحة';

  @override
  String get noDownloads => 'لا توجد تنزيلات بعد';

  @override
  String get noDownloadsBody =>
      'نزّل المواد من صفحة التصفح للوصول إليها أوفلاين';

  @override
  String get quizSelectSubject => 'اختر مادة للاختبار';

  @override
  String get quizStart => 'بدء الاختبار';

  @override
  String questionOf(int current, int total) {
    return 'سؤال $current من $total';
  }

  @override
  String get correctAnswer => 'إجابة صحيحة';

  @override
  String get wrongAnswer => 'إجابة خاطئة';

  @override
  String get quizResult => 'نتيجتك';

  @override
  String scoreOf(int score, int total) {
    return '$score من $total';
  }

  @override
  String get retryQuiz => 'إعادة الاختبار';

  @override
  String get offlineBanner =>
      'أنت في وضع أوفلاين — تعرض البيانات المحفوظة مسبقاً';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get errorGeneral => 'حدث خطأ، يرجى المحاولة مجدداً';

  @override
  String get guestNoSave => 'الضيف لا يحفظ تقدمه';
}
