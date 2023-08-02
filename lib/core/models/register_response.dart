abstract class AuthResponse {}

class Success extends AuthResponse {}

class Error extends AuthResponse {
  final String message;

  Error({required this.message});
}
