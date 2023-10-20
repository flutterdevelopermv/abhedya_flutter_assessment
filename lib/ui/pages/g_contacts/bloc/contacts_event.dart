part of 'contacts_bloc.dart';

sealed class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

final class ContactsFetchEvent extends ContactsEvent {
  final Map<String, dynamic> data;
  const ContactsFetchEvent(this.data);
}
