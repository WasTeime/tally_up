import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/Controller.dart';
import 'package:tally_up/src/core/data/models/UserDBModel.dart';
import 'package:tally_up/src/features/contacts_invitings/data/models/ContactDBModel.dart';
import 'package:tally_up/src/features/contacts_invitings/data/models/ContactInvitationDBModel.dart';

class InvitingsController extends Controller {
  late final ContactDBModel _contactsDBModel;
  late final ContactInvitationDBModel _contactsInvitationsDBModel;
  final UserDBModel _usersDBModel = UserDBModel();
  //TODO: при регистрации сделать модель какие коллекции будут создаваться у пользователя
  //TODO: посмотреть нужно ли закрывать stream

  InvitingsController() {
    _contactsDBModel = ContactDBModel(super.getUserUid);
    _contactsInvitationsDBModel = ContactInvitationDBModel(super.getUserUid);
  }

  Stream<QuerySnapshot> get getContactsInvitationsStream =>
      _contactsInvitationsDBModel.getStream;

  Future<bool> sendContactRequestToAnotherUser(String phone) async {
    //TODO: сюда можно try catch
    //TODO: если телефон не существует то Exception
    //TODO: проверку есть ли пользователь уже в друзьях
    //TODO: сделать оповещение
    //проверить, что будет если ввести не существующий номер
    DocumentSnapshot? recieverUserDoc = await _usersDBModel
        .getCollection()
        .where('phone', isEqualTo: phone)
        .get()
        .then((QuerySnapshot querySnapshot) =>
            {if (querySnapshot.size > 0) querySnapshot.docs[0]})
        .then((recieverUserDoc) =>
            (recieverUserDoc.isNotEmpty) ? recieverUserDoc.first : null);
    if (recieverUserDoc != null) {
      DocumentReference senderUserDoc =
          _usersDBModel.getCollection().doc(super.getUserUid);

      _contactsInvitationsDBModel
          .getContactsInvitationsCollectionForAnotherUser(recieverUserDoc.id)
          .add({'user': senderUserDoc});
    }
    return recieverUserDoc != null;
  }

  //TODO ВАЖНО ПИЗДА ПРОСТО
  //TODO: короче какая хуйня с async await, со стримами надо короче посмотреть как все работает, потому что пока все как-то хаотично, дебагером еще раз пройтись по пути создания приглашения, принятия заявки и т.д.
  void acceptUserToContact(String docId) async {
    DocumentReference invitingList_senderUserDoc =
        _contactsInvitationsDBModel.getCollection().doc(docId);

    DocumentReference senderUserRef =
        await invitingList_senderUserDoc.get().then((doc) => doc.get('user'));
    DocumentReference recieverUserRef =
        _usersDBModel.getCollection().doc(super.getUserUid);

    invitingList_senderUserDoc.delete();

    DocumentReference recieverDocRefInContactList = await _contactsDBModel
        .getCollection()
        .add({
      'user': senderUserRef,
      'ref_on_doc_in_another_user_contact_list': ""
    });
    DocumentReference senderDocRefInContactList = await _contactsDBModel
        .getContactsCollectionForAnotherUser(senderUserRef.id)
        .add({
      'user': recieverUserRef,
      'ref_on_doc_in_another_user_contact_list': ""
    });

    await recieverDocRefInContactList.set(
      {'ref_on_doc_in_another_user_contact_list': senderDocRefInContactList},
      SetOptions(merge: true),
    );
    await senderDocRefInContactList.set(
      {'ref_on_doc_in_another_user_contact_list': recieverDocRefInContactList},
      SetOptions(merge: true),
    );
  }

  void discardUserToContact(String docId) {
    _contactsInvitationsDBModel.getCollection().doc(docId).delete();
  }

  Future<List<Map<String, dynamic>>> getUserInvitings(
    QuerySnapshot querySnapshot,
  ) async {
    List<Map<String, dynamic>> contactsInvitationsList = [];
    for (var doc in querySnapshot.docs) {
      await getDocFieldsByRef(doc.get('user')).then((contactData) {
        contactData['contacts_invitings_doc_id'] = doc.id;
        contactsInvitationsList.add(contactData);
      });
    }
    return contactsInvitationsList;
  }
}
