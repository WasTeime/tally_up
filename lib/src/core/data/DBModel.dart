import 'package:cloud_firestore/cloud_firestore.dart';

class DBModel {
  final _db = FirebaseFirestore.instance;
  final String _collectionName;

  DBModel({collectionName = "users"}) : _collectionName = collectionName;

  CollectionReference getCollection({String userUid = ""}) =>
      _db.collection(_collectionName);

  DocumentReference getDoc(String userUid) => getCollection().doc(userUid);

  get getCollectionName => _collectionName;
}
