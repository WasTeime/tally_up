import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/DBModel.dart';

class FriendDBModel extends DBModel {
  FriendDBModel() : super();

  @override
  CollectionReference getCollection({String? userUid}) {
    return super.getDoc(userUid!).collection('friends');
  }

  @override
  DocumentReference getDoc(String userUid, {String docId = ""}) {
    return getCollection().doc(docId);
  }
}
