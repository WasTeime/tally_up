import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/DBModel.dart';

class FriendDBModel extends DBModel {
  FriendDBModel() : super();

  CollectionReference getCollection(String userUid) =>
      super.getRootDoc(userUid).collection('friends');

  DocumentReference getDoc(String userUid, String docId) =>
      getCollection(userUid).doc(docId);
}
