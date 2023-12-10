part of 'groups_bloc.dart';

abstract class GroupsState {}

class GroupsInitial extends GroupsState {}

class GroupsLoading extends GroupsState {}

class GroupsLoaded extends GroupsState {
  final List<Map<String, dynamic>> groups;

  GroupsLoaded(this.groups);
}

class GroupsFailure extends GroupsState {}
