part of 'friends_bloc.dart';

abstract class FriendsEvent {}

class FriendsLoadingEvent extends FriendsEvent {
  QuerySnapshot querySnapshot;

  FriendsLoadingEvent(this.querySnapshot);
}

class DeleteFriend extends FriendsEvent {
  final Map<String, dynamic> dataForDelete;

  DeleteFriend(this.dataForDelete);
}
