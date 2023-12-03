import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/features/friends_and_invitings/data/repository/friendsController.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final FriendsController friendsController = FriendsController();
  late final StreamSubscription contactsSub;

  ContactsBloc() : super(ContactsInitial()) {
    contactsSub = friendsController.streamContacts.listen((friendsList) {
      if (friendsList.isNotEmpty) {
        emit(ContactsLoaded(friendsList));
      }
    });

    on<ContactsLoadingEvent>((event, emit) async {
      emit(ContactsLoading());
      friendsController.getUserFriends();
      //await Future.delayed(Duration(seconds: 1));
    });
  }
}
