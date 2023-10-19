import  'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc() : super(AccountsInitial()) {
    on<AccountsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
