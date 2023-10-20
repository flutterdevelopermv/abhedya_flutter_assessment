import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
part 'graph_query_result_event.dart';
part 'graph_query_result_state.dart';

class QueryResultBloc extends Bloc<QueryResultEvent, QueryResultState> {
  QueryResultBloc() : super(QueryInitial()) {
    on<QueryResultEvent>((event, emit) async {
      try {
        if (event.result.data != null) {
          emit(QuerySuccess(event.result.data!));
        } else if (event.result.isLoading) {
          emit(QueryLoading());
        } else {
          final connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult == ConnectivityResult.none) {
            emit(const QueryNetworkLost());
          } else if (event.result.exception?.graphqlErrors.isNotEmpty == true) {
            emit(QueryApiFailure(
                event.result.exception!.graphqlErrors.first.message));
          } else if (event.result.exception?.linkException != null) {
            emit(QueryApiFailure(
                event.result.exception!.graphqlErrors.first.message));
          } else {
            emit(const QueryUnknownError());
          }
        }
      } catch (e) {
        emit(const QueryUnknownError());
      }
    });
  }
}
