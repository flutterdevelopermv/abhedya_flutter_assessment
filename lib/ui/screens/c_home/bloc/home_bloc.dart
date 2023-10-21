import 'package:abhedya_flutter_assessment/data/models/profile.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeProfileInitial()) {
    on<HomeProfileEvent>((event, emit) {
      try {
        var profile = Profile.fromMap(event.data['home']);
        emit(HomeProfileSuccess(profile));
      } catch (e) {
        emit(HomeProfileError(event.data));
      }
    });
  }
}
