import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

/// UserEntity مبسّطة مؤقتاً — ستُكمَل في Task 4 مع MockAuthDataSource
class UserEntity {
  const UserEntity({required this.id, required this.isGuest, this.name, this.email});

  final String id;
  final bool isGuest;
  final String? name;
  final String? email;
}

/// AuthNotifier مؤقت
/// يبقى في حالة loading حتى تُنهي SplashScreen عملها وتستدعي checkAuthStatus()
/// هذا يمنع GoRouter من الـ redirect خلال فترة الـ Splash
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<UserEntity?> build() async {
    // نبقى في loading — SplashScreen تستدعي checkAuthStatus() بعد 2.6 ثانية
    return Future.value(null).then((_) async {
      // ننتظر أن تُفعَّل checkAuthStatus من الـ Splash
      // لا نُكمل حتى يتم ذلك
      await Future.delayed(const Duration(days: 365));
      return null;
    });
  }

  /// تُستدعى من SplashScreen بعد انتهاء الـ delay
  /// تُحدّد حالة المستخدم وتُحرّر GoRouter من الـ loading
  Future<void> checkAuthStatus() async {
    // Mock: لا يوجد مستخدم مسجل
    state = const AsyncData(null);
  }

  /// الدخول كضيف بدون حساب
  Future<void> signInAsGuest() async {
    state = const AsyncData(UserEntity(id: 'guest', isGuest: true));
  }

  /// تسجيل الخروج
  Future<void> signOut() async {
    state = const AsyncData(null);
  }
}
