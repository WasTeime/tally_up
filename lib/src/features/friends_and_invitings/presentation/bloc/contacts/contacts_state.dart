part of 'contacts_bloc.dart';

abstract class ContactsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactsInitial extends ContactsState {}

class ContactsLoading extends ContactsState {}

class ContactsLoaded extends ContactsState {
  final List contacts;

  ContactsLoaded(this.contacts);
}

class ContactsFailure extends ContactsState {}

class ContactsListEmpty extends ContactsState {}
