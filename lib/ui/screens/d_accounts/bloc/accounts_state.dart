part of 'accounts_bloc.dart';

@immutable
sealed class AccountsState extends Equatable {
  const AccountsState();

  @override
  List<Object> get props => [];
}

final class AccountsInitial extends AccountsState {
  @override
  List<Object> get props => [];
}

final class AccountsListSuccess extends AccountsState {
  final List<Account> listAccounts;
  const AccountsListSuccess(this.listAccounts);

  @override
  List<Object> get props => [listAccounts];
}

final class AccountsListError extends AccountsState {
  final Map<String, dynamic> data;
  const AccountsListError(this.data);

  @override
  List<Object> get props => [data];
}
