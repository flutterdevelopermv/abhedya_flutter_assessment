part of 'accounts_bloc.dart';

@immutable
sealed class AccountsState {}

final class AccountsInitial extends AccountsState {}

final class AccountsListSuccess extends AccountsState {
  final List<Account> listAccounts;
  AccountsListSuccess(this.listAccounts);
}

final class AccountsListError extends AccountsState {
  final Map<String, dynamic> data;
  AccountsListError(this.data);
}
