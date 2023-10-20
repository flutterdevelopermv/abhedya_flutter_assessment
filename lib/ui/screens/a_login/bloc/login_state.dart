part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

//
class LoginPasswordObscureState extends LoginState {
  final bool obscureText;
  const LoginPasswordObscureState(this.obscureText);

  @override
  List<Object> get props => [obscureText];
}

//
class LoginButtonState extends LoginState {}

class LoginButtonStateLoding extends LoginState {}
