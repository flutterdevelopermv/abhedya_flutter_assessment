part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginPasswordToggleEvent extends LoginEvent {
  final bool obscureText;
  LoginPasswordToggleEvent(this.obscureText);
}

class LoginButtonEvent extends LoginEvent {
  final String username;
  final String password;
  LoginButtonEvent({required this.username, required this.password});
}
