import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tally_up/src/features/friends_and_invitings/data/models/FriendDBModel.dart';

class FriendsController {
  final _userUid = FirebaseAuth.instance.currentUser!.uid;
  late final FriendDBModel _friendsDBModel;
  late final Stream<QuerySnapshot> _friendsStream;

  FriendsController() {
    _friendsStream =
        _friendsDBModel.getCollection(userUid: _userUid).snapshots();
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
    _friendsDBModel
        .getDoc(_userUid, docId: dataForDelete['executorUserDocRef'])
        .delete();
    DocumentReference friendDocRef = dataForDelete['friendDocRef'];
    friendDocRef.delete();
  }
}
