import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/features/friends_and_invitings/data/repository/friendsController.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final friendsController = FriendsController();
  late final StreamSubscription friendsSub;

  FriendsBloc() : super(FriendsInitial()) {
    friendsSub = friendsController.friendsListInDBStream.listen(
        (QuerySnapshot querySnapshot) =>
            add(FriendsLoadingEvent(querySnapshot)));

    on<FriendsLoadingEvent>((event, emit) async {
      //TODO: протестировать если пользователь будет находиться на другой странице, будет ли ui обновляться
      //Ожидание: ничего не должно обновляться на ui, только когда пользователь сюда заходит, пусть тут обновляется
      //TODO: нужна оптимизация с помощью equatable и чтобы если появился новый пользователь заново все не переделывать, а просто посмотреть новые добавленные документы docsChanges
      emit(FriendsLoading());
      await friendsController
          .getUserFriends(event.querySnapshot)
          .then((friends) {
        if (friends.isEmpty) {
          emit(FriendsListEmpty());
        } else {
          //TODO: нужны проверки, если чето не так
          friends.sort((a, b) => a['username'].compareTo(b['username']));
          emit(FriendsLoaded(friends));
        }
      });
    });

    on<DeleteFriend>((event, emit) {
      friendsController.deleteContact(event.dataForDelete);
    });
  }

  @override
  Future<void> close() {
    friendsSub.cancel();
    return super.close();
  }
}
