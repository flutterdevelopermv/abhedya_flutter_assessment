part of 'contacts_bloc.dart';

sealed class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object> get props => [];
}

final class ContactsInitial extends ContactsState {}

final class ContactsSuccess extends ContactsState {
  final List<Contact> listContacts;
  const ContactsSuccess(this.listContacts);
}

final class ContactsError extends ContactsState {
  final Map<String, dynamic> data;
  const ContactsError(this.data);
}
