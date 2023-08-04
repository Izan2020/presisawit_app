import 'package:presisawit_app/core/models/login_credentials.dart';
import 'package:presisawit_app/core/models/register_credentials.dart';
import 'package:presisawit_app/core/models/register_response.dart';
import 'package:presisawit_app/core/repository/auth_repository.dart';

class AuthUsecases {
  final AuthRepository authRepository;
  AuthUsecases(this.authRepository);

  Future<DataState> loginUser(LoginCredentials user) =>
      authRepository.loginUser(user);

  Future<DataState> regsiterUser(RegisterCredentials user) =>
      authRepository.registerUser(user);
}
