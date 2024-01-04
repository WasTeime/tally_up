part of 'invitings_bloc.dart';

//TODO: разобраться с Equtable
abstract class InvitingsEvent {}

class SearchUserForPhone extends InvitingsEvent {
  final String phone;

  SearchUserForPhone(this.phone);
}

class InvitingsListLoading extends InvitingsEvent {
  QuerySnapshot querySnapshot;

  InvitingsListLoading(this.querySnapshot);
}

class AcceptUserToContacts extends InvitingsEvent {
  final String docId;

  AcceptUserToContacts(this.docId);
}

class DiscardUserToContacts extends InvitingsEvent {
  final String docId;

  DiscardUserToContacts(this.docId);
}
