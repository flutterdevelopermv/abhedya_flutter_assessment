part of 'statement_bloc.dart';

@immutable
sealed class StatementsEvent {}

final class StatemenntsListEvent extends StatementsEvent {
  final Map<String, dynamic> data;
  StatemenntsListEvent(this.data);
}
