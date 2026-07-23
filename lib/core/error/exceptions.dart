class ServerException implements Exception {
  const ServerException([this.message = 'حدث خطأ في الاتصال بالخادم.']);
  final String message;
}

class CacheException implements Exception {
  const CacheException([this.message = 'حدث خطأ في التخزين المحلي.']);
  final String message;
}

class AuthException implements Exception {
  const AuthException([this.message = 'فشلت عملية المصادقة.']);
  final String message;
}
