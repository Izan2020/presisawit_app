import 'package:equatable/equatable.dart';

abstract class AuthResponse extends Equatable {}

class Success extends AuthResponse {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Error extends AuthResponse {
  final String message;

  Error({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
