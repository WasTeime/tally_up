part of 'invitings_bloc.dart';

abstract class InvitingsState {}

class InvitingsInitial extends InvitingsState {}

class InvitingsLoading extends InvitingsState {}

class InvitingsLoaded extends InvitingsState {
  final List invitings;

  InvitingsLoaded(this.invitings);
}

class InvitingsFailure extends InvitingsState {}

class PeopleNotFound extends InvitingsState {}

class PeopleFound extends InvitingsState {}
