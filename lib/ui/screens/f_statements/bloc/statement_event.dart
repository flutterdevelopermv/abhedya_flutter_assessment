part of 'statement_bloc.dart';

@immutable
sealed class StatementsEvent extends Equatable {
  const StatementsEvent();

  @override
  List<Object> get props => [];
}

final class StatemenntsListEvent extends StatementsEvent {
  final Map<String, dynamic> data;
  const StatemenntsListEvent(this.data);

  @override
  List<Object> get props => [data];
}
