/// أسماء المسارات الثابتة — Deep Linking جاهز
abstract final class RouteNames {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String home = '/home';
  static const String browse = '/browse';
  static const String resources = '/resources/:subjectId';
  static const String downloads = '/downloads';
  static const String quiz = '/quiz';
  static const String quizPlay = '/quiz/:subjectId';

  // Helper لبناء المسار مع parameters
  static String resourcesPath(String subjectId) => '/resources/$subjectId';
  static String quizPlayPath(String subjectId) => '/quiz/$subjectId';
}
