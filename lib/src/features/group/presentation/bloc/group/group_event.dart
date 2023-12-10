part of 'group_bloc.dart';

abstract class GroupEvent {}

class LoadGroup extends GroupEvent {
  final QuerySnapshot querySnapshot;

  LoadGroup(this.querySnapshot);
}
