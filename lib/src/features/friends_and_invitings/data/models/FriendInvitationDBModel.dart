import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/DBModel.dart';

class FriendInvitationDBModel extends DBModel {
  FriendInvitationDBModel() : super();

  @override
  CollectionReference getCollection({String? userUid}) {
    return super.getDoc(userUid!).collection('friends_invitation');
  }

  @override
  DocumentReference getDoc(String userUid, {String docId = ""}) {
    return getCollection().doc(docId);
  }
}
