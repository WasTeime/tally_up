part of 'contacts_bloc.dart';

abstract class ContactsState {}

class ContactsInitial extends ContactsState {}

class ContactsLoading extends ContactsState {}

//TODO: разобраться с Equatable
class ContactsLoaded extends ContactsState {
  final List<Map<String, dynamic>> contacts;

  ContactsLoaded(this.contacts);
}

class ContactsFailure extends ContactsState {}
