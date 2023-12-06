import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendsController {
  final _db = FirebaseFirestore.instance;
  final _userUid = FirebaseAuth.instance.currentUser!.uid;
  late final CollectionReference _friendsCollection;
  late final Stream<QuerySnapshot> _friendsStream;

  FriendsController() {
    _friendsCollection =
        _db.collection('users').doc(_userUid).collection('friends');
    _friendsStream = _friendsCollection.snapshots();
  }

  Stream<QuerySnapshot> get friendsListInDBStream => _friendsStream;

  Future<Map<String, dynamic>> getDocFieldsOnRef(
      DocumentReference docRef) async {
    DocumentSnapshot doc = await docRef.get();
    return doc.data() as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> getUserFriends(
      QuerySnapshot querySnapshot) async {
    List<Map<String, dynamic>> friendsList = [];
    for (var doc in querySnapshot.docs) {
      await getDocFieldsOnRef(doc.get('user')).then((friendData) {
        friendData['data_for_delete'] = {
          'executorUserDocRef': doc.id,
          'friendDocRef': doc.get('ref_on_doc_in_another_user_friend_list')
        };
        friendsList.add(friendData);
      });
    }
    return friendsList;
  }

  void deleteContact(Map<String, dynamic> dataForDelete) {
    //удаляем документы в коллекциях friends у обоих пользователей
    _friendsCollection.doc(dataForDelete['executorUserDocRef']).delete();
    DocumentReference friendDocRef = dataForDelete['friendDocRef'];
    friendDocRef.delete();
  }
}
