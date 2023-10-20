import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../data/models/statement.dart';
part 'statement_event.dart';
part 'statement_state.dart';

class StatementsBloc extends Bloc<StatementsEvent, StatementsState> {
  StatementsBloc() : super(StatementsInitial()) {
    on<StatemenntsListEvent>((event, emit) {
      try {
        var listStatements = Statement.getList(event.data);
        var sortedSatements = Statement.sortedMapList(listStatements);
        emit(StatementsListSuccess(sortedSatements));
      } catch (e) {
        emit(StatementsListError(event.data));
      }
    });
  }
}
