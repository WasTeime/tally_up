import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DBModel {
  final _db = FirebaseFirestore.instance;
  final String _collectionName;

  DBModel({collectionName = "users"}) : _collectionName = collectionName;

  CollectionReference getCollection({String? userUid}) =>
      _db.collection(_collectionName);

  DocumentReference getDoc(String userUid, {String docId = ""}) =>
      getCollection().doc(userUid);

  // CollectionReference getSubCollection(String userUid) =>
  //     _db.collection('users').doc(userUid).collection(_subCollectionName);

  get getCollectionName => _collectionName;
}
