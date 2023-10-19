part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class PasswordToggleLoginEvent extends LoginEvent {
  final bool isObscure;
  PasswordToggleLoginEvent(this.isObscure);
}

class LoginButtonEvent extends LoginEvent {
  final String username;
  final String password;
  LoginButtonEvent({required this.username,required this.password});

}