part of 'auth_bloc.dart';

@immutable
class AuthEvent {}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;

  AuthEventLogin({required this.email, required this.password});
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;

  AuthEventRegister({required this.email, required this.password});
}
