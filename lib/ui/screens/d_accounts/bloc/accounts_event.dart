part of 'accounts_bloc.dart';

@immutable
sealed class AccountsEvent extends Equatable {
  const AccountsEvent();

  @override
  List<Object> get props => [];
}

final class AccountsListEvent extends AccountsEvent {
  final Map<String, dynamic> data;
  const AccountsListEvent(this.data);

  @override
  List<Object> get props => [data];
}
