class ServerException implements Exception {
  ServerException(this.message, this.errorResponse);

  final String? message;
  final dynamic errorResponse;
}

class CacheException implements Exception {
  CacheException(this.message);

  final String? message;
}
