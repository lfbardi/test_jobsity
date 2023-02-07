abstract class Failure {
  String errorMessage;

  Failure({
    required this.errorMessage,
  });
}

class ServerFailure extends Failure {
  final String errorMessage;

  ServerFailure({
    this.errorMessage = 'An error happened. Please try again.',
  }) : super(errorMessage: errorMessage);
}

class LocalHiveFailure extends Failure {
  final String errorMessage;

  LocalHiveFailure({
    this.errorMessage = 'An error happened. Please try again.',
  }) : super(errorMessage: errorMessage);
}
