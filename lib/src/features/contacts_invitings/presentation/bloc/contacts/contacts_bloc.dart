import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/features/contacts_invitings/data/repository/contactsController.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final contactsController = ContactsController();
  late final StreamSubscription contactsSub;

  ContactsBloc() : super(ContactsInitial()) {
    contactsSub = contactsController.contactsListInDBStream.listen(
        (QuerySnapshot querySnapshot) => add(ContactsLoadEvent(querySnapshot)));

    on<ContactsLoadEvent>((event, emit) async {
      //TODO: протестировать если пользователь будет находиться на другой странице, будет ли ui обновляться
      //Ожидание: ничего не должно обновляться на ui, только когда пользователь сюда заходит, пусть тут обновляется
      //TODO: нужна оптимизация с помощью equatable и чтобы если появился новый пользователь заново все не переделывать, а просто посмотреть новые добавленные документы docsChanges
      emit(ContactsLoading());
      await contactsController
          .getUserContacts(event.querySnapshot)
          .then((contacts) {
        if (contacts.isNotEmpty) {
          //TODO: нужны проверки, если чето не так
          contacts.sort((a, b) => a['username'].compareTo(b['username']));
          for (var element in contacts) {
            element['check'] = ValueNotifier(false);
          }
        }
        emit(ContactsLoaded(contacts));
      });
    });

    on<DeleteContact>((event, emit) {
      contactsController.deleteContact(event.dataForDelete);
    });
  }

  @override
  Future<void> close() {
    contactsSub.cancel();
    return super.close();
  }
}
