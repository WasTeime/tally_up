part of 'contacts_bloc.dart';

abstract class ContactsEvent {}

class ContactsLoadEvent extends ContactsEvent {
  QuerySnapshot querySnapshot;

  ContactsLoadEvent(this.querySnapshot);
}

class DeleteContact extends ContactsEvent {
  final Map<String, dynamic> dataForDelete;

  DeleteContact(this.dataForDelete);
}
