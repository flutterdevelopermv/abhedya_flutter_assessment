part of 'main_bloc.dart';

//
sealed class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

final class BottomBarState extends MainState {
  final int currentIndex;
  const BottomBarState(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
