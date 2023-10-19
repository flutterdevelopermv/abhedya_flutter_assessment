part of 'main_bloc.dart';

//
sealed class MainEvent {}

class BottomBarClickedEvent extends MainEvent {
  final int index;
  BottomBarClickedEvent(this.index);
}
