part of 'groups_bloc.dart';

abstract class GroupsState {}

class GroupsInitial extends GroupsState {}

class GroupsLoading extends GroupsState {}

class GroupsLoaded extends GroupsState {}

class GroupsFailure extends GroupsState {}
