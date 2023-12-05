import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsController {
  final _db = FirebaseFirestore.instance;
  //final Stream<Map<String, dynamic>> _contacts = Stream.empty();
  final _contacts = StreamController<List<Map<String, dynamic>>>();
  List<Map<String, dynamic>> _contactsList = [];

  Future<Map<String, dynamic>> getUserInfo(DocumentReference docRef) async {
    DocumentSnapshot documentSnapshot = await docRef.get();
    return documentSnapshot.data() as Map<String, dynamic>;
  }

  Stream<List<Map<String, dynamic>>> get streamContacts => _contacts.stream;

  void getUserFriends() async {
    final Stream<QuerySnapshot> contactsStream = await _db
        .collection('users')
        .doc('VrqSl8J0jEmCyCpOCaXa')
        .collection('friends')
        .snapshots();
    contactsStream.listen((querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        var friendData = await getUserInfo(doc.get('friend'));
        _contactsList.add(friendData);
      }
      _contacts.add(_contactsList);
    });
  }
}
