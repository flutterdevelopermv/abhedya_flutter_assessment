import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const BottomBarState(0)) {
    on<BottomBarClickedEvent>((event, emit) {
      emit(BottomBarState(event.currentIndex));
    });
  }
}
