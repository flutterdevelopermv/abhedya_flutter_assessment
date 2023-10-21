// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/contact.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsInitial()) {
    on<ContactsFetchEvent>((event, emit) {
      try {
        var listContacts = Contact.getList(event.data);

        emit(ContactsSuccess(listContacts));
      } catch (e) {
        emit(ContactsError(event.data));
      }
    });
  }
}
