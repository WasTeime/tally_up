import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tally_up/src/core/data/models/UserDBModel.dart';
import 'package:tally_up/src/features/friends_and_invitings/data/models/FriendDBModel.dart';
import 'package:tally_up/src/features/friends_and_invitings/data/models/FriendInvitationDBModel.dart';

//TODO: можно сделать один класс родитель а friends и invitings будут наследники
class InvitingsController {
  final _userUid = FirebaseAuth.instance.currentUser!.uid;
  final FriendDBModel _friendsDBModel = FriendDBModel();
  final FriendInvitationDBModel _friendsInvitationsDBModel =
      FriendInvitationDBModel();
  final UserDBModel _usersDBModel = UserDBModel();
  //TODO: при регистрации сделать модель какие коллекции будут создаваться у пользователя
  //TODO: посмотреть нужно ли закрывать stream
  late Stream<QuerySnapshot> _friendsInvitationsStream;

  InvitingsController() {
    _friendsInvitationsStream =
        _friendsInvitationsDBModel.getCollection(userUid: _userUid).snapshots();
  }

  Stream<QuerySnapshot> get friendsInvitationsListInDBStream =>
      _friendsInvitationsStream;

  Future<Map<String, dynamic>> getDocFieldsOnRef(
      DocumentReference docRef) async {
    DocumentSnapshot doc = await docRef.get();
    return doc.data() as Map<String, dynamic>;
  }

  Future<bool> sendRequestToFriend(String phone) async {
    //TODO: сюда можно try catch
    //TODO: если телефон не существует то Exception
    //TODO: проверку есть ли пользователь уже в друзьях
    //TODO: сделать оповещение
    var recieverUserDoc = await _usersDBModel
        .getRootCollection()
        .where('phone', isEqualTo: phone)
        .get()
        .then((QuerySnapshot querySnapshot) =>
            {if (querySnapshot.size > 0) querySnapshot.docs[0]})
        .then((recieverUserDoc) => recieverUserDoc.first);
    DocumentReference senderUserDoc = _usersDBModel.getRootDoc(_userUid);
    _friendsInvitationsDBModel
        .getCollection(userUid: recieverUserDoc.id)
        .add({'user': senderUserDoc});
    return recieverUserDoc.exists;
  }

  //TODO ВАЖНО ПИЗДА ПРОСТО
  //TODO: короче какая хуйня с async await, со стримами надо короче посмотреть как все работает, потому что пока все как-то хаотично, дебагером еще раз пройтись по пути создания приглашения, принятия заявки и т.д.
  void acceptUserToFriend(String docId) async {
    DocumentReference invitingList_senderUserDoc =
        _friendsInvitationsDBModel.getDoc(_userUid, docId: docId);

    DocumentReference senderUserRef =
        await invitingList_senderUserDoc.get().then((doc) => doc.get('user'));
    DocumentReference recieverUserRef = _usersDBModel.getRootDoc(_userUid);

    invitingList_senderUserDoc.delete();

    DocumentReference recieverDocRefInFriendList = await _friendsDBModel
        .getCollection(_userUid)
        .add({
      'user': senderUserRef,
      'ref_on_doc_in_another_user_friend_list': ""
    });
    DocumentReference senderDocRefInFriendList = await _friendsDBModel
        .getCollection(senderUserRef.id)
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
    _friendsInvitationsDBModel.getDoc(_userUid, docId: docId).delete();
  }

  Future<List<Map<String, dynamic>>> getUserInvitings(
      QuerySnapshot querySnapshot) async {
    List<Map<String, dynamic>> friendsInvitationsList = [];
    for (var doc in querySnapshot.docs) {
      await getDocFieldsOnRef(doc.get('user')).then((friendData) {
        friendData['friends_invitings_doc_id'] = doc.id;
        friendsInvitationsList.add(friendData);
      });
    }
    return friendsInvitationsList;
  }
}
