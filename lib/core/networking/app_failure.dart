enum AppFailureType {
  invalidCredentials,
  unknown,
}

final class AppFailure {
  const AppFailure({
    required this.type,
  });

  final AppFailureType type;
}