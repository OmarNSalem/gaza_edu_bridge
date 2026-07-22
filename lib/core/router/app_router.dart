import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/auth_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/browse/presentation/screens/browse_screen.dart';
import '../../features/quiz/presentation/screens/quiz_screen.dart';
import '../../features/downloads/presentation/screens/downloads_screen.dart';
import '../../features/resources/presentation/screens/resources_screen.dart';
import '../../features/auth/presentation/providers/auth_notifier.dart';
import 'route_names.dart';
import '../shell/app_shell.dart';

part 'app_router.g.dart';

/// GoRouter provider — يراقب authNotifierProvider ويُعيد التوجيه تلقائياً
@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: RouteNames.splash,
    redirect: (context, state) {
      // انتظر حتى ينتهي تحميل الـ auth state
      if (authState.isLoading) return null;

      final user = authState.valueOrNull;
      final loc = state.matchedLocation;

      // المسارات التي لا تتطلب تسجيل دخول
      final isAuthRoute = loc == RouteNames.splash ||
          loc == RouteNames.onboarding ||
          loc == RouteNames.auth;

      // غير مسجل ويحاول الوصول لصفحة محمية
      if (user == null && !isAuthRoute) return RouteNames.auth;

      // مسجل ويحاول الوصول لصفحة تسجيل الدخول
      if (user != null && loc == RouteNames.auth) return RouteNames.home;

      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RouteNames.auth,
        builder: (context, state) => const AuthScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: RouteNames.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: RouteNames.browse,
            builder: (context, state) => const BrowseScreen(),
          ),
          GoRoute(
            path: RouteNames.quiz,
            builder: (context, state) => const QuizScreen(),
          ),
          GoRoute(
            path: RouteNames.downloads,
            builder: (context, state) => const DownloadsScreen(),
          ),
          GoRoute(
            path: RouteNames.resources,
            builder: (context, state) => ResourcesScreen(
              subjectId: state.pathParameters['subjectId']!,
            ),
          ),
        ],
      ),
    ],
  );
}
