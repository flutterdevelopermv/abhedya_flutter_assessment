part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginPasswordToggleEvent extends LoginEvent {
  final bool obscureText;
  const LoginPasswordToggleEvent(this.obscureText);

  @override
  List<Object> get props => [obscureText];
}

class LoginButtonEvent extends LoginEvent {
  final String username;
  final String password;
  const LoginButtonEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username,password];
}
