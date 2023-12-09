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

class AcceptUserToFriends extends InvitingsEvent {
  final String docId;

  AcceptUserToFriends(this.docId);
}

class DiscardUserToFriends extends InvitingsEvent {
  final String docId;

  DiscardUserToFriends(this.docId);
}
