import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In ar, this message translates to:
  /// **'GazaEdu Bridge'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In ar, this message translates to:
  /// **'منصة غزة للتعلم الذاتي'**
  String get appTagline;

  /// No description provided for @university.
  ///
  /// In ar, this message translates to:
  /// **'جامعة فلسطين — 2025/2026'**
  String get university;

  /// No description provided for @skip.
  ///
  /// In ar, this message translates to:
  /// **'تخطي'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get next;

  /// No description provided for @startNow.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ الآن'**
  String get startNow;

  /// No description provided for @back.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get back;

  /// No description provided for @open.
  ///
  /// In ar, this message translates to:
  /// **'فتح'**
  String get open;

  /// No description provided for @download.
  ///
  /// In ar, this message translates to:
  /// **'تنزيل'**
  String get download;

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get confirm;

  /// No description provided for @logout.
  ///
  /// In ar, this message translates to:
  /// **'خروج'**
  String get logout;

  /// No description provided for @onboarding1Title.
  ///
  /// In ar, this message translates to:
  /// **'تعلّم بدون إنترنت'**
  String get onboarding1Title;

  /// No description provided for @onboarding1TitleEn.
  ///
  /// In ar, this message translates to:
  /// **'Learn Offline'**
  String get onboarding1TitleEn;

  /// No description provided for @onboarding1Body.
  ///
  /// In ar, this message translates to:
  /// **'نزّل المواد مرة واحدة واستمر في التعلم حتى بدون اتصال بالإنترنت.'**
  String get onboarding1Body;

  /// No description provided for @onboarding2Title.
  ///
  /// In ar, this message translates to:
  /// **'حمّل ملفاتك بسهولة'**
  String get onboarding2Title;

  /// No description provided for @onboarding2TitleEn.
  ///
  /// In ar, this message translates to:
  /// **'Easy Downloads'**
  String get onboarding2TitleEn;

  /// No description provided for @onboarding2Body.
  ///
  /// In ar, this message translates to:
  /// **'ملفات PDF منظمة حسب المرحلة والصف، بأحجام صغيرة وجاهزة للقراءة في أي وقت.'**
  String get onboarding2Body;

  /// No description provided for @welcome.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً بك'**
  String get welcome;

  /// No description provided for @continueWithGoogle.
  ///
  /// In ar, this message translates to:
  /// **'متابعة بحساب Google'**
  String get continueWithGoogle;

  /// No description provided for @login.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل دخول'**
  String get login;

  /// No description provided for @register.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get register;

  /// No description provided for @continueAsGuest.
  ///
  /// In ar, this message translates to:
  /// **'متابعة كضيف'**
  String get continueAsGuest;

  /// No description provided for @guestNote.
  ///
  /// In ar, this message translates to:
  /// **'بدون تسجيل — مؤقت'**
  String get guestNote;

  /// No description provided for @orContinueWithout.
  ///
  /// In ar, this message translates to:
  /// **'أو تابع بدون حساب'**
  String get orContinueWithout;

  /// No description provided for @fullName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الكامل'**
  String get fullName;

  /// No description provided for @email.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get email;

  /// No description provided for @password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get confirmPassword;

  /// No description provided for @createNewAccount.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب جديد'**
  String get createNewAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In ar, this message translates to:
  /// **'لديك حساب بالفعل؟ '**
  String get alreadyHaveAccount;

  /// No description provided for @dontHaveAccount.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك حساب؟ '**
  String get dontHaveAccount;

  /// No description provided for @createAccount.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء الحساب'**
  String get createAccount;

  /// No description provided for @home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get home;

  /// No description provided for @browse.
  ///
  /// In ar, this message translates to:
  /// **'التصفح'**
  String get browse;

  /// No description provided for @quizzes.
  ///
  /// In ar, this message translates to:
  /// **'اختبارات'**
  String get quizzes;

  /// No description provided for @downloads.
  ///
  /// In ar, this message translates to:
  /// **'تنزيلات'**
  String get downloads;

  /// No description provided for @levelPrimary.
  ///
  /// In ar, this message translates to:
  /// **'ابتدائي'**
  String get levelPrimary;

  /// No description provided for @levelMiddle.
  ///
  /// In ar, this message translates to:
  /// **'إعدادي'**
  String get levelMiddle;

  /// No description provided for @levelHigh.
  ///
  /// In ar, this message translates to:
  /// **'ثانوي'**
  String get levelHigh;

  /// No description provided for @levelAll.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get levelAll;

  /// No description provided for @gradeLabel.
  ///
  /// In ar, this message translates to:
  /// **'صف {grade}'**
  String gradeLabel(int grade);

  /// No description provided for @branchScience.
  ///
  /// In ar, this message translates to:
  /// **'علمي'**
  String get branchScience;

  /// No description provided for @branchArts.
  ///
  /// In ar, this message translates to:
  /// **'أدبي'**
  String get branchArts;

  /// No description provided for @searchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن مادة...'**
  String get searchHint;

  /// No description provided for @noSubjectsFound.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد مواد مطابقة للبحث'**
  String get noSubjectsFound;

  /// No description provided for @files.
  ///
  /// In ar, this message translates to:
  /// **'{count} ملف'**
  String files(int count);

  /// No description provided for @typeSummary.
  ///
  /// In ar, this message translates to:
  /// **'ملخص'**
  String get typeSummary;

  /// No description provided for @typeExplanation.
  ///
  /// In ar, this message translates to:
  /// **'شرح'**
  String get typeExplanation;

  /// No description provided for @typeExercises.
  ///
  /// In ar, this message translates to:
  /// **'تمارين'**
  String get typeExercises;

  /// No description provided for @downloadedNote.
  ///
  /// In ar, this message translates to:
  /// **'تم التنزيل'**
  String get downloadedNote;

  /// No description provided for @downloadingNote.
  ///
  /// In ar, this message translates to:
  /// **'جاري التنزيل...'**
  String get downloadingNote;

  /// No description provided for @deleteDownload.
  ///
  /// In ar, this message translates to:
  /// **'حذف التنزيل'**
  String get deleteDownload;

  /// No description provided for @totalStorage.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي المساحة'**
  String get totalStorage;

  /// No description provided for @noDownloads.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد تنزيلات بعد'**
  String get noDownloads;

  /// No description provided for @noDownloadsBody.
  ///
  /// In ar, this message translates to:
  /// **'نزّل المواد من صفحة التصفح للوصول إليها أوفلاين'**
  String get noDownloadsBody;

  /// No description provided for @quizSelectSubject.
  ///
  /// In ar, this message translates to:
  /// **'اختر مادة للاختبار'**
  String get quizSelectSubject;

  /// No description provided for @quizStart.
  ///
  /// In ar, this message translates to:
  /// **'بدء الاختبار'**
  String get quizStart;

  /// No description provided for @questionOf.
  ///
  /// In ar, this message translates to:
  /// **'سؤال {current} من {total}'**
  String questionOf(int current, int total);

  /// No description provided for @correctAnswer.
  ///
  /// In ar, this message translates to:
  /// **'إجابة صحيحة'**
  String get correctAnswer;

  /// No description provided for @wrongAnswer.
  ///
  /// In ar, this message translates to:
  /// **'إجابة خاطئة'**
  String get wrongAnswer;

  /// No description provided for @quizResult.
  ///
  /// In ar, this message translates to:
  /// **'نتيجتك'**
  String get quizResult;

  /// No description provided for @scoreOf.
  ///
  /// In ar, this message translates to:
  /// **'{score} من {total}'**
  String scoreOf(int score, int total);

  /// No description provided for @retryQuiz.
  ///
  /// In ar, this message translates to:
  /// **'إعادة الاختبار'**
  String get retryQuiz;

  /// No description provided for @offlineBanner.
  ///
  /// In ar, this message translates to:
  /// **'أنت في وضع أوفلاين — تعرض البيانات المحفوظة مسبقاً'**
  String get offlineBanner;

  /// No description provided for @loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري التحميل...'**
  String get loading;

  /// No description provided for @errorGeneral.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ، يرجى المحاولة مجدداً'**
  String get errorGeneral;

  /// No description provided for @guestNoSave.
  ///
  /// In ar, this message translates to:
  /// **'الضيف لا يحفظ تقدمه'**
  String get guestNoSave;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
