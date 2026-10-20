import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:e_commerce_app/core/networking/api_constants.dart';
import 'package:e_commerce_app/features/auth/data/models/login_request.dart';
import 'package:e_commerce_app/features/auth/data/models/login_response.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String? baseUrl}) = _AuthApiService;

  @POST(ApiEndpoints.login)
  @Extra({ApiConstants.requiresAuthKey: false})
  Future<LoginResponse> login(@Body() LoginRequest request);
}
