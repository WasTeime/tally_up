part of 'friends_bloc.dart';

abstract class FriendsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FriendsInitial extends FriendsState {}

class FriendsLoading extends FriendsState {}

//TODO: разобраться с Equatable
class FriendsLoaded extends FriendsState {
  final List<Map<String, dynamic>> friends;

  FriendsLoaded(this.friends);
}

class FriendsFailure extends FriendsState {}

class FriendsListEmpty extends FriendsState {}
