part of 'groupe_bloc.dart';

class GroupState {}

class GroupLoading extends GroupState {}

class GroupLoaded extends GroupState {
  // final List<Groups> group;

  // GroupLoaded( this.group);
}

class GroupLoadingFailure extends GroupState {
  final String error;

  GroupLoadingFailure(this.error);
}

// class Groups{
//   final String id;

//   Groups({required this.id});
// }