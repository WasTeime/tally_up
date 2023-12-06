import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/DBModel.dart';

class FriendDBModel extends DBModel {
  FriendDBModel() : super();

  @override
  CollectionReference getCollection({String userUid = ""}) =>
      super.getCollection().doc(userUid).collection('friends');

  @override
  DocumentReference getDoc(String userUid, {String docId = ""}) =>
      getCollection().doc(docId);
}
