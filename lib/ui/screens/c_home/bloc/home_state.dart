part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeProfileInitial extends HomeState {}

final class HomeProfileSuccess extends HomeState {
  final Profile profile;
  const HomeProfileSuccess(this.profile);

  @override
  List<Object> get props => [profile];
}

final class HomeProfileError extends HomeState {
  final Map<String, dynamic> data;
  const HomeProfileError(this.data);

  @override
  List<Object> get props => [data];
}
