part of 'create_group_bloc.dart';

abstract class CreateGroupState {}

class CreateGroupInitial extends CreateGroupState {}

class CreateGroupLoading extends CreateGroupState {}

class CreateGroupLoaded extends CreateGroupState {
  DocumentReference createdGroupRef;

  CreateGroupLoaded(this.createdGroupRef);
}

class CreateGroupFailure extends CreateGroupState {}
