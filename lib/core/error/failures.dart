/// Sealed class للأخطاء — يُستخدم مع Either من fpdart
sealed class Failure {
  const Failure(this.message);
  final String message;
}

/// خطأ Firebase (Auth, Firestore, Storage)
final class FirebaseFailure extends Failure {
  const FirebaseFailure(super.message);
}

/// خطأ الشبكة / الاتصال
final class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// خطأ التحقق من المدخلات
final class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// خطأ التخزين المحلي
final class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// خطأ صلاحيات (المستخدم غير مصرح له)
final class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

/// خطأ غير متوقع
final class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'حدث خطأ غير متوقع، يرجى المحاولة مجدداً']);
}
