part of 'groups_bloc.dart';

abstract class GroupsEvent {}

class LoadGroups extends GroupsEvent {
  QuerySnapshot querySnapshot;

  LoadGroups(this.querySnapshot);
}
