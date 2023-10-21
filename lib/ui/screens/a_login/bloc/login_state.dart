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

class LoginButtonErrorSate extends LoginState {
  final String message;
 const LoginButtonErrorSate(this.message);
 
  @override
  List<Object> get props => [message];
}