abstract final class ApiConstants {
  static const String baseUrl = 'https://dummyjson.com/';

  static const Duration connectTimeout = Duration(seconds: 20);
  static const Duration receiveTimeout = Duration(seconds: 20);

  static const int tokenExpiryMinutes = 30;
  static const int productsPageSize = 30;

  static const String requiresAuthKey = 'requiresAuth';
  static const List<String> errorMessageKeys = ['message', 'error'];
}

abstract final class ApiEndpoints {
  static const String login = 'auth/login';
  static const String refreshToken = 'auth/refresh';

  static const String products = 'auth/products';
}
