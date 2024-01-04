import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/features/contacts_invitings/data/repository/invitingsController.dart';

part 'invitings_event.dart';
part 'invitings_state.dart';

class InvitingsBloc extends Bloc<InvitingsEvent, InvitingsState> {
  final invitingsController = InvitingsController();
  late final StreamSubscription invitingsContactsSub;

  InvitingsBloc() : super(InvitingsInitial()) {
    invitingsContactsSub = invitingsController.getContactsInvitationsStream
        .listen((QuerySnapshot querySnapshot) =>
            add(InvitingsListLoading(querySnapshot)));

    on<SearchUserForPhone>((event, emit) async {
      bool isPhoneExist = await invitingsController
          .sendContactRequestToAnotherUser(event.phone);
      //TODO: сюда можно try catch
      isPhoneExist ? emit(PeopleFound()) : emit(PeopleNotFound());
    });

    on<AcceptUserToContacts>((event, emit) {
      invitingsController.acceptUserToContact(event.docId);
    });

    on<DiscardUserToContacts>((event, emit) {
      invitingsController.discardUserToContact(event.docId);
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
    invitingsContactsSub.cancel();
    return super.close();
  }
}
