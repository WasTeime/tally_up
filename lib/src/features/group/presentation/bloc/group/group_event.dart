part of 'group_bloc.dart';

abstract class GroupEvent {}

class LoadGroup extends GroupEvent {
  final QuerySnapshot querySnapshot;
  final DocumentReference groupRef;

  LoadGroup(this.querySnapshot, {required this.groupRef});
}

// class LoadGroupEvents extends GroupEvent {
//   final DocumentReference groupRef;

//   LoadGroupEvents({required this.groupRef});
// }

class CreateGroup extends GroupEvent {
  final String groupName;
  final List<DocumentReference> groupParticipants;

  CreateGroup(this.groupName, this.groupParticipants);
}
