import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/Controller.dart';
import 'package:tally_up/src/features/contacts_invitings/data/models/ContactDBModel.dart';

class ContactsController extends Controller {
  late final ContactDBModel _contactsDBModel;

  ContactsController() {
    _contactsDBModel = ContactDBModel(super.getUserUid);
  }

  Stream<QuerySnapshot> get contactsListInDBStream =>
      _contactsDBModel.getStream;

  Future<List<Map<String, dynamic>>> getUserContacts(
    QuerySnapshot querySnapshot,
  ) async {
    List<Map<String, dynamic>> contactsList = [];

    for (var doc in querySnapshot.docs) {
      await getDocFieldsByRef(doc.get('user')).then((friendData) {
        friendData['user_ref'] = doc.get('user');
        friendData['data_for_delete'] = {
          'executorUserDocRef': doc.id,
          'friendDocRef': doc.get('ref_on_doc_in_another_user_contact_list'),
        };
        contactsList.add(friendData);
      });
    }

    return contactsList;
  }

  void deleteContact(Map<String, dynamic> dataForDelete) {
    //удаляем документы в коллекциях friends у обоих пользователей
    _contactsDBModel
        .getCollection()
        .doc(dataForDelete['executorUserDocRef'])
        .delete();
    DocumentReference friendDocRef = dataForDelete['friendDocRef'];
    friendDocRef.delete();
  }
}
