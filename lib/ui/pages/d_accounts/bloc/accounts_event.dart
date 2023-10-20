part of 'accounts_bloc.dart';

@immutable
sealed class AccountsEvent {}

final class AccountsListEvent extends AccountsEvent {
   final Map<String, dynamic> data;
  AccountsListEvent(this.data);
}
