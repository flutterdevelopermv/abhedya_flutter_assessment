part of 'graph_query_result_bloc.dart';

class QueryResultEvent extends Equatable {
  final QueryResult result;
  const QueryResultEvent(this.result);

  @override
  List<Object> get props => [result];
}
