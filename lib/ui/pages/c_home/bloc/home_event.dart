part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeProfileEvent extends HomeEvent {
  final Map<String, dynamic> data;
  HomeProfileEvent(this.data);
}
