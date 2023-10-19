part of 'login_bloc.dart';

class LoginState {}

//
class LoginPasswordObscureState extends LoginState {
  final bool obscureText;
  LoginPasswordObscureState(this.obscureText);
}


//
class LoginButtonState extends LoginState {}

class LoginButtonStateLoding extends LoginState {}
