import '../classes/login_credentials.dart';
import '../classes/register_credentials.dart';
import '../classes/logic/data_response.dart';

abstract class AuthRepository {
  Future<DataState> registerUser(RegisterCredentials user);
  Future<DataState> loginUser(LoginCredentials user);
  Future<bool> isLoggedIn();
  Future<DataState> getSavedCredentials();
}
