import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tally_up/src/core/data/Controller.dart';
import 'package:tally_up/src/features/friends_and_invitings/data/models/FriendDBModel.dart';

class FriendsController extends Controller {
  late final FriendDBModel _friendsDBModel;

  FriendsController() {
    _friendsDBModel = FriendDBModel(super.getUserUid);
  }

  Stream<QuerySnapshot> get friendsListInDBStream => _friendsDBModel.getStream;

  Future<List<Map<String, dynamic>>> getUserFriends(
      QuerySnapshot querySnapshot) async {
    List<Map<String, dynamic>> friendsList = [];
    for (var doc in querySnapshot.docs) {
      await getDocFieldsByRef(doc.get('user')).then((friendData) {
        friendData['data_for_delete'] = {
          'executorUserDocRef': doc.id,
          'friendDocRef': doc.get('ref_on_doc_in_another_user_friend_list'),
        };
        friendsList.add(friendData);
      });
    }
    return friendsList;
  }

  void deleteFriend(Map<String, dynamic> dataForDelete) {
    //удаляем документы в коллекциях friends у обоих пользователей
    _friendsDBModel
        .getCollection()
        .doc(dataForDelete['executorUserDocRef'])
        .delete();
    DocumentReference friendDocRef = dataForDelete['friendDocRef'];
    friendDocRef.delete();
  }
}
