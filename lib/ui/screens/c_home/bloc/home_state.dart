part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeProfileInitial extends HomeState {}

final class HomeProfileSuccess extends HomeState {
  final Profile profile;
  HomeProfileSuccess(this.profile);
}

final class HomeProfileError extends HomeState {
  final Map<String, dynamic> data;
  HomeProfileError(this.data);
}
