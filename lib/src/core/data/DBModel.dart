import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DBModel {
  final _db = FirebaseFirestore.instance;
  final String _collectionName;
  final String _subCollectionName;

  DBModel({collectionName = "users", subCollectionName = ""})
      : _collectionName = collectionName,
        _subCollectionName = subCollectionName;

  CollectionReference getCollection(String userUid) =>
      _db.collection(_collectionName);

  CollectionReference getSubCollectionInUsers(String userUid) =>
      _db.collection('users').doc(userUid).collection(_subCollectionName);

  get getCollectionName => _collectionName;
}
