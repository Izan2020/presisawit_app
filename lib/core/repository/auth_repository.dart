import '../models/login_credentials.dart';
import '../models/register_credentials.dart';
import '../models/register_response.dart';

abstract class AuthRepository {
  Future<DataState> registerUser(RegisterCredentials user);
  Future<DataState> loginUser(LoginCredentials user);
  Future<bool> isLoggedIn();
}
