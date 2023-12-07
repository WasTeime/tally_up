import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/DBModel.dart';

class FriendInvitationDBModel extends DBModel {
  FriendInvitationDBModel() : super();

  //вот так нельзя (почему: https://stackoverflow.com/questions/73514859/why-does-the-call-to-a-parent-class-constructor-not-call-the-parents-methods-th)
  // @override
  // CollectionReference getCollection({String? userUid}) {
  //   return super.getDoc(userUid!).collection('friends_invitation');
  // }

  CollectionReference getCollection({String? userUid}) =>
      super.getRootCollection().doc(userUid).collection('friends_invitations');

  DocumentReference getDoc(String userUid, {String docId = ""}) =>
      getCollection(userUid: userUid).doc(docId);
}
