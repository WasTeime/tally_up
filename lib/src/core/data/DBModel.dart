import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DBModel {
  final _db = FirebaseFirestore.instance;
  final String _collectionName;

  DBModel({collectionName = "users"}) : _collectionName = collectionName;

  CollectionReference getRootCollection() => _db.collection(_collectionName);

  DocumentReference getRootDoc(String userUid) =>
      getRootCollection().doc(userUid);

  get getCollectionName => _collectionName;
}
