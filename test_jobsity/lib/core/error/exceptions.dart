class ServerException implements Exception {
  final String message;

  ServerException({required this.message});
}

class HiveException implements Exception {
  final String message;

  HiveException({required this.message});
}
