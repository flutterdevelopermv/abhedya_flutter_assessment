part of 'graph_query_result_bloc.dart';

sealed class QueryResultState extends Equatable {
  const QueryResultState();

  @override
  List<Object> get props => [];
}

final class QueryInitial extends QueryResultState {}

final class QueryLoading extends QueryResultState {}

final class QuerySuccess extends QueryResultState {
  final Map<String, dynamic> data;
  const QuerySuccess(this.data);
}

final class QueryNetworkLost extends QueryResultState {
  const QueryNetworkLost();
}

final class QueryApiFailure extends QueryResultState {
  final String message;
  const QueryApiFailure(this.message);
}

final class QueryLinkException extends QueryResultState {
  final LinkException linkException;
  const QueryLinkException(this.linkException);
}

final class QueryUnknownError extends QueryResultState {
  const QueryUnknownError();
}
