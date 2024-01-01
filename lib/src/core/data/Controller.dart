import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Controller {
  final _user = FirebaseAuth.instance.currentUser;

  String get getUserUid => _user!.uid;

  User? get getUser => _user;

  //получить данные документы по ссылке (DocumentReference) на документ
  Future<Map<String, dynamic>> getDocFieldsByRef(
    DocumentReference docRef,
  ) async {
    DocumentSnapshot doc = await docRef.get();
    return doc.data() as Map<String, dynamic>;
  }

  //получить все документы коллекции по запросу (QuerySnapshot)
  Future<List<Map<String, dynamic>>> getCollectionDocs(
    QuerySnapshot querySnapshot,
  ) async {
    List<Map<String, dynamic>> docsList = [];
    for (var doc in querySnapshot.docs) {
      docsList.add(doc.data() as Map<String, dynamic>);
    }
    return docsList;
  }

  //получить все документы коллекции по запросу (QuerySnapshot), где есть только одно поле: ссылка на пользователя
  Future<List<Map<String, dynamic>>> getCollectionDocsWithUserRefField(
    QuerySnapshot querySnapshot,
  ) async {
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
