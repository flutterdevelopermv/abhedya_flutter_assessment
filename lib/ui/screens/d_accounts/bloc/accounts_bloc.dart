import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../../data/models/account.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc() : super(AccountsInitial()) {
    on<AccountsListEvent>((event, emit) {
      try {
        var listAccounts = Account.getList(event.data);
        emit(AccountsListSuccess(listAccounts));
      } catch (e) {
        emit(AccountsListError(event.data));
      }
    });
  }
}
