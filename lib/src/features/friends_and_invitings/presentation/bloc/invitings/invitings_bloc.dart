import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/features/friends_and_invitings/data/repository/invitingsController.dart';

part 'invitings_event.dart';
part 'invitings_state.dart';

class InvitingsBloc extends Bloc<InvitingsEvent, InvitingsState> {
  final invitingsController = InvitingsController();
  late final StreamSubscription invitingsFriendsSub;

  InvitingsBloc() : super(InvitingsInitial()) {
    invitingsFriendsSub = invitingsController.friendsInvitationsListInDBStream
        .listen((QuerySnapshot querySnapshot) =>
            add(InvitingsListLoading(querySnapshot)));

    on<SearchUserForPhone>((event, emit) async {
      var isPhoneExist =
          await invitingsController.sendRequestToFriend(event.phone);
      //TODO: сюда можно try catch
      isPhoneExist ? emit(PeopleFound()) : emit(PeopleNotFound());
    });

    on<AcceptUserToFriends>((event, emit) {
      invitingsController.acceptUserToFriend(event.docId);
    });

    on<DiscardUserToFriends>((event, emit) {
      invitingsController.discardUserToFriend(event.docId);
    });

    on<InvitingsListLoading>((event, emit) async {
      List<Map<String, dynamic>> invitings = [];
      //TODO: протестировать если пользователь будет находиться на другой странице будет ли ui обновляться
      //Ожидание: ничего не должно обновляться на ui, только когда пользователь сюда заходит, пусть тут обновляется
      emit(InvitingsLoading());
      invitings =
          await invitingsController.getUserInvitings(event.querySnapshot);
      //TODO: нужны проверки, если чето не так
      invitings.sort((a, b) => a['username'].compareTo(b['username']));
      emit(InvitingsLoaded(invitings));
      //await Future.delayed(Duration(seconds: 1));
    });
  }

  @override
  Future<void> close() {
    invitingsFriendsSub.cancel();
    return super.close();
  }
}
