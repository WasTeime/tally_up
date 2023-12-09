import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tally_up/src/core/data/Controller.dart';
import 'package:tally_up/src/core/data/models/UserDBModel.dart';
import 'package:tally_up/src/features/friends_and_invitings/data/models/FriendDBModel.dart';
import 'package:tally_up/src/features/friends_and_invitings/data/models/FriendInvitationDBModel.dart';

class InvitingsController extends Controller {
  late final FriendDBModel _friendsDBModel;
  late final FriendInvitationDBModel _friendsInvitationsDBModel;
  final UserDBModel _usersDBModel = UserDBModel();
  //TODO: при регистрации сделать модель какие коллекции будут создаваться у пользователя
  //TODO: посмотреть нужно ли закрывать stream

  InvitingsController() {
    _friendsDBModel = FriendDBModel(super.getUserUid);
    _friendsInvitationsDBModel = FriendInvitationDBModel(super.getUserUid);
  }

  Stream<QuerySnapshot> get getFriendsInvitationsStream =>
      _friendsInvitationsDBModel.getStream;

  Future<bool> sendFriendRequestToAnotherUser(String phone) async {
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

      _friendsInvitationsDBModel
          .getFriendsInvitationsCollectionForAnotherUser(recieverUserDoc.id)
          .add({'user': senderUserDoc});
    }
    return recieverUserDoc != null;
  }

  //TODO ВАЖНО ПИЗДА ПРОСТО
  //TODO: короче какая хуйня с async await, со стримами надо короче посмотреть как все работает, потому что пока все как-то хаотично, дебагером еще раз пройтись по пути создания приглашения, принятия заявки и т.д.
  void acceptUserToFriend(String docId) async {
    DocumentReference invitingList_senderUserDoc =
        _friendsInvitationsDBModel.getCollection().doc(docId);

    DocumentReference senderUserRef =
        await invitingList_senderUserDoc.get().then((doc) => doc.get('user'));
    DocumentReference recieverUserRef =
        _usersDBModel.getCollection().doc(super.getUserUid);

    invitingList_senderUserDoc.delete();

    DocumentReference recieverDocRefInFriendList = await _friendsDBModel
        .getCollection()
        .add({
      'user': senderUserRef,
      'ref_on_doc_in_another_user_friend_list': ""
    });
    DocumentReference senderDocRefInFriendList = await _friendsDBModel
        .getFriendsCollectionForAnotherUser(senderUserRef.id)
        .add({
      'user': recieverUserRef,
      'ref_on_doc_in_another_user_friend_list': ""
    });

    await recieverDocRefInFriendList.set(
        {'ref_on_doc_in_another_user_friend_list': senderDocRefInFriendList},
        SetOptions(merge: true));
    await senderDocRefInFriendList.set(
        {'ref_on_doc_in_another_user_friend_list': recieverDocRefInFriendList},
        SetOptions(merge: true));
  }

  void discardUserToFriend(String docId) {
    _friendsInvitationsDBModel.getCollection().doc(docId).delete();
  }

  Future<List<Map<String, dynamic>>> getUserInvitings(
      QuerySnapshot querySnapshot) async {
    List<Map<String, dynamic>> friendsInvitationsList = [];
    for (var doc in querySnapshot.docs) {
      await getDocFieldsByRef(doc.get('user')).then((friendData) {
        friendData['friends_invitings_doc_id'] = doc.id;
        friendsInvitationsList.add(friendData);
      });
    }
    return friendsInvitationsList;
  }
}
