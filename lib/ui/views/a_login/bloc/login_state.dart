part of 'login_bloc.dart';

@immutable
sealed class LoginState {}


//
 class PasswordLoginState extends LoginState {
 }
 class PasswordShowLoginState extends PasswordLoginState {
 }
 class PasswordHideLoginState extends PasswordLoginState { 
 }

 //
 class LoginButtonState extends LoginState {
 }
  class LoginButtonStateLoding extends LoginState {
 }

