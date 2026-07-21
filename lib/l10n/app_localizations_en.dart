// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'GazaEdu Bridge';

  @override
  String get appTagline => 'Gaza Self-Learning Platform';

  @override
  String get university => 'Palestine University — 2025/2026';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get startNow => 'Get Started';

  @override
  String get back => 'Back';

  @override
  String get open => 'Open';

  @override
  String get download => 'Download';

  @override
  String get delete => 'Delete';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get logout => 'Logout';

  @override
  String get onboarding1Title => 'تعلّم بدون إنترنت';

  @override
  String get onboarding1TitleEn => 'Learn Offline';

  @override
  String get onboarding1Body =>
      'Download materials once and keep learning even without internet.';

  @override
  String get onboarding2Title => 'حمّل ملفاتك بسهولة';

  @override
  String get onboarding2TitleEn => 'Easy Downloads';

  @override
  String get onboarding2Body =>
      'PDF files organized by grade, small in size and ready to read anytime.';

  @override
  String get welcome => 'Welcome';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get login => 'Login';

  @override
  String get register => 'Sign Up';

  @override
  String get continueAsGuest => 'Continue as Guest';

  @override
  String get guestNote => 'No registration — temporary';

  @override
  String get orContinueWithout => 'Or continue without account';

  @override
  String get fullName => 'Full Name';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get createNewAccount => 'Create New Account';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get createAccount => 'Create Account';

  @override
  String get home => 'Home';

  @override
  String get browse => 'Browse';

  @override
  String get quizzes => 'Quizzes';

  @override
  String get downloads => 'Downloads';

  @override
  String get levelPrimary => 'Primary';

  @override
  String get levelMiddle => 'Middle';

  @override
  String get levelHigh => 'High School';

  @override
  String get levelAll => 'All';

  @override
  String gradeLabel(int grade) {
    return 'Grade $grade';
  }

  @override
  String get branchScience => 'Science';

  @override
  String get branchArts => 'Arts';

  @override
  String get searchHint => 'Search for a subject...';

  @override
  String get noSubjectsFound => 'No subjects match your search';

  @override
  String files(int count) {
    return '$count files';
  }

  @override
  String get typeSummary => 'Summary';

  @override
  String get typeExplanation => 'Explanation';

  @override
  String get typeExercises => 'Exercises';

  @override
  String get downloadedNote => 'Downloaded';

  @override
  String get downloadingNote => 'Downloading...';

  @override
  String get deleteDownload => 'Delete Download';

  @override
  String get totalStorage => 'Total Storage';

  @override
  String get noDownloads => 'No downloads yet';

  @override
  String get noDownloadsBody =>
      'Download materials from the browse page to access them offline';

  @override
  String get quizSelectSubject => 'Select a subject for quiz';

  @override
  String get quizStart => 'Start Quiz';

  @override
  String questionOf(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String get correctAnswer => 'Correct';

  @override
  String get wrongAnswer => 'Wrong';

  @override
  String get quizResult => 'Your Score';

  @override
  String scoreOf(int score, int total) {
    return '$score out of $total';
  }

  @override
  String get retryQuiz => 'Retry Quiz';

  @override
  String get offlineBanner => 'You are offline — showing cached data';

  @override
  String get loading => 'Loading...';

  @override
  String get errorGeneral => 'Something went wrong, please try again';

  @override
  String get guestNoSave => 'Guest progress is not saved';
}
