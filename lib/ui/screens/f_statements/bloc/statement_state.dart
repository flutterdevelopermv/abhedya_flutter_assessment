part of 'statement_bloc.dart';

@immutable
sealed class StatementsState extends Equatable {
  const StatementsState();

  @override
  List<Object> get props => [];
}

final class StatementsInitial extends StatementsState {}

final class StatementsListSuccess extends StatementsState {
  final Map<int, List<Statement>> sortedSatements;
  const StatementsListSuccess(this.sortedSatements);

  @override
  List<Object> get props => [sortedSatements];
}

final class StatementsListError extends StatementsState {
  final Map<String, dynamic> data;
  const StatementsListError(this.data);

  @override
  List<Object> get props => [data];
}
