// Exceptions داخلية تُستخدم في Data Layer فقط
// تُحوَّل إلى Failure في Repository

class FirebaseAuthException implements Exception {
  const FirebaseAuthException(this.message);
  final String message;
}

class FirestoreException implements Exception {
  const FirestoreException(this.message);
  final String message;
}

class StorageException implements Exception {
  const StorageException(this.message);
  final String message;
}

class NetworkException implements Exception {
  const NetworkException(this.message);
  final String message;
}

class CacheException implements Exception {
  const CacheException(this.message);
  final String message;
}
