import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/auth_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/subjects/presentation/screens/browse_screen.dart';
import '../../features/resources/presentation/screens/resources_screen.dart';
import '../../features/downloads/presentation/screens/downloads_screen.dart';
import '../../shared/widgets/app_shell.dart';
import '../../shared/widgets/placeholder_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      // ── شاشات بدون BottomNav ──
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
      // ── شاشات مع BottomNav ──
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.browse,
                builder: (context, state) {
                  final initialLevelId = state.extra as String?;
                  return BrowseScreen(initialLevelId: initialLevelId);
                },
              ),
              GoRoute(
                path: RouteNames.resources,
                builder: (context, state) {
                  final subjectId = state.extra as String?;
                  return ResourcesScreen(subjectId: subjectId);
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.quiz,
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'الاختبار'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.downloads,
                builder: (context, state) => const DownloadsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
