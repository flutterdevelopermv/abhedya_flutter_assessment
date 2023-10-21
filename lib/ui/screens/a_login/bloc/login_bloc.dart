import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginPasswordObscureState(true)) {
    on<LoginPasswordToggleEvent>((event, emit) {
      emit(LoginPasswordObscureState(event.obscureText));
    });

    on<LoginButtonErrorEvent>((event, emit) {
      emit(LoginButtonErrorSate(event.message));
    });
  }
}
