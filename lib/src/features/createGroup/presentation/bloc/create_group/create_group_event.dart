part of 'create_group_bloc.dart';

abstract class CreateGroupEvent {}

class LoadCreateGroupScreen extends CreateGroupEvent {}

class CreateGroup extends CreateGroupEvent {
  final String groupName;
  final List<DocumentReference> groupParticipants;

  CreateGroup(this.groupName, this.groupParticipants);
}
