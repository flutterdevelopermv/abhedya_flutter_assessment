part of 'main_bloc.dart';

//
sealed class MainState {}

final class BottomBarState extends MainState {
  final int index;
  BottomBarState(this.index);
}
