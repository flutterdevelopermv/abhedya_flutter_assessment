part of 'statement_bloc.dart';

@immutable
sealed class StatementsState {}

final class StatementsInitial extends StatementsState {}

final class StatementsListSuccess extends StatementsState {
  final Map<int, List<Statement>> sortedSatements;
  StatementsListSuccess(this.sortedSatements);
}

final class StatementsListError extends StatementsState {
  final Map<String, dynamic> data;
  StatementsListError(this.data);
}
