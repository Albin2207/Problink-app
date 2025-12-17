class ServerException implements Exception {
  final String message;
  final String? code;

  ServerException(this.message, {this.code});

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => message;
}

class AuthException implements Exception {
  final String message;
  final String? code;

  AuthException(this.message, {this.code});

  @override
  String toString() => message;
}

