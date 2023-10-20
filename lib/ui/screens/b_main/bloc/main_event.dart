part of 'main_bloc.dart';

//
sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class BottomBarClickedEvent extends MainEvent {
  final int currentIndex;
  const BottomBarClickedEvent(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
