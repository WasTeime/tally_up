part of 'group_bloc.dart';

abstract class GroupState {}

class GroupInitial extends GroupState {}

//LOAD GROUP
class GroupLoading extends GroupState {}

class GroupLoaded extends GroupState {
  final Map<String, dynamic> groupDetails;

  GroupLoaded(this.groupDetails);
}

class GroupFailure extends GroupState {}

//CREATE GROUP
class GroupCreating extends GroupState {}

class GroupCreated extends GroupState {
  DocumentReference createdGroupRef;

  GroupCreated(this.createdGroupRef);
}

class GroupCreateFailure extends GroupState {}
