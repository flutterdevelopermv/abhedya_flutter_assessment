part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class HomeProfileEvent extends HomeEvent {
  final Map<String, dynamic> data;
  const HomeProfileEvent(this.data);
  @override
  List<Object> get props => [data];
}
