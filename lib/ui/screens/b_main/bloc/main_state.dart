part of 'main_bloc.dart';

//
sealed class MainState {}

final class BottomBarState extends MainState {
  final int currentIndex;
  BottomBarState(this.currentIndex);
}
