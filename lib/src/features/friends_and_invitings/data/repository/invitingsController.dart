import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tally_up/src/core/data/models/UserDBModel.dart';
import 'package:tally_up/src/features/friends_and_invitings/data/models/FriendDBModel.dart';
import 'package:tally_up/src/features/friends_and_invitings/data/models/FriendInvitationDBModel.dart';

//TODO: можно сделать один класс родитель а friends и invitings будут наследники
class InvitingsController {
  final _db = FirebaseFirestore.instance;
  final _userUid = FirebaseAuth.instance.currentUser!.uid;
  late final FriendDBModel _friendsDBModel;
  late final FriendInvitationDBModel _friendsInvitationsDBModel;
  late final UserDBModel _usersDBModel;
  //TODO: при регистрации сделать модель какие коллекции будут создаваться у пользователя
  //TODO: посмотреть нужно ли закрывать stream
  late Stream<QuerySnapshot> _friendsInvitationsStream;

  InvitingsController() {
    _friendsInvitationsStream =
        _friendsDBModel.getCollection(_userUid).snapshots();
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
        .getCollection(_userUid)
        .where('phone', isEqualTo: phone)
        .get()
        .then((QuerySnapshot querySnapshot) =>
            {if (querySnapshot.size > 0) querySnapshot.docs[0]})
        .then((recieverUserDoc) => recieverUserDoc.first);
    DocumentReference senderUserDoc =
        _usersDBModel.getCollection(_userUid).doc(_userUid);
    _friendsInvitationsDBModel
        .getSubCollectionInUsers(recieverUserDoc.id)
        .add({'user': senderUserDoc});
    _db
        .collection('users')
        .doc(recieverUserDoc.id)
        .collection('friends_invitations')
        .add({'user': senderUserDoc});
    return recieverUserDoc.exists;
  }

  void acceptUserToFriend(String docId) async {
    DocumentReference invitingList_senderUserDoc = _db
        .collection('users')
        .doc(_userUid)
        .collection('friends_invitations')
        .doc(docId);

    DocumentReference senderUserRef =
        await invitingList_senderUserDoc.get().then((doc) => doc.get('user'));
    DocumentReference recieverUserRef = _db.collection('users').doc(_userUid);

    CollectionReference recieverUserFriendsCollection =
        _db.collection('users').doc(_userUid).collection('friends');
    CollectionReference senderUserFriendsCollection =
        _db.collection('users').doc(senderUserRef.id).collection('friends');

    invitingList_senderUserDoc.delete();

    DocumentReference recieverDocRefInFriendList =
        await recieverUserFriendsCollection.add({'user': senderUserRef});
    DocumentReference senderDocRefInFriendList =
        await senderUserFriendsCollection.add({'user': recieverUserRef});

    await recieverDocRefInFriendList.set(
        {'ref_on_doc_in_another_user_friend_list': senderDocRefInFriendList},
        SetOptions(merge: true));
    await senderDocRefInFriendList.set(
        {'ref_on_doc_in_another_user_friend_list': recieverDocRefInFriendList},
        SetOptions(merge: true));
  }

  void discardUserToFriend(String docId) {
    _db
        .collection('users')
        .doc(_userUid)
        .collection('friends_invitations')
        .doc(docId)
        .delete();
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
