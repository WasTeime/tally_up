import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Controller {
  final _user = FirebaseAuth.instance.currentUser;

  String get getUserUid => _user!.uid;

  User? get getUser => _user;

  Future<Map<String, dynamic>> getDocFieldsByRef(
      DocumentReference docRef) async {
    DocumentSnapshot doc = await docRef.get();
    return doc.data() as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> getCollectionDocs(
      QuerySnapshot querySnapshot) async {
    List<Map<String, dynamic>> docsList = [];
    for (var doc in querySnapshot.docs) {
      docsList.add(doc.data() as Map<String, dynamic>);
    }
    return docsList;
  }

  Future<List<Map<String, dynamic>>> getCollectionDocsWithUserRefField(
      QuerySnapshot querySnapshot) async {
    List<Map<String, dynamic>> docsList = [];
    for (var doc in querySnapshot.docs) {
      await getDocFieldsByRef(doc.get('user')).then((docData) {
        docsList.add(docData);
      });
    }
    return docsList;
  }

  void deleteDoc(DocumentReference doc) => doc.delete();
}
