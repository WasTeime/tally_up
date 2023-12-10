part of 'group_bloc.dart';

abstract class GroupState {}

class GroupInitial extends GroupState {}

class GroupLoaded extends GroupState {
  final Map<String, dynamic> groupDetails;

  GroupLoaded(this.groupDetails);
}

class GroupLoading extends GroupState {}

class GroupFailure extends GroupState {}
