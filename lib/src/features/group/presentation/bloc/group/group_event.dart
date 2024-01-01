part of 'group_bloc.dart';

abstract class GroupEvent {}

class LoadGroup extends GroupEvent {
  final QuerySnapshot querySnapshot;

  LoadGroup(this.querySnapshot);
}

class GetGroupParticipants extends GroupEvent {
  final DocumentReference groupRef;

  GetGroupParticipants(this.groupRef);
}
