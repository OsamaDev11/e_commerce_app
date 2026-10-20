enum AppFailureType {
  noInternet,
  timeout,
  cancelled,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  server,
  parsing,
  unknown,
}

final class AppFailure {
  const AppFailure(
    this.type, {
    this.statusCode,
    this.serverMessage,
  });

  final AppFailureType type;
  final int? statusCode;
  final String? serverMessage;
}
