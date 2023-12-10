import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DBModel {
  final _db = FirebaseFirestore.instance;
  //{'1 layer collection': '1 layer doc', '2 layer collection': '2 layer doc', ...}
  late final CollectionReference _collection;

  DBModel({required Map<String, String?> pathToCollection}) {
    _collection = _getCollectionByCollectionsDocsPath(pathToCollection);
  }

  CollectionReference getCollection(
          {Map<String, String?>? anotherCollectionDocPaths}) =>
      anotherCollectionDocPaths == null
          ? _collection
          : _getCollectionByCollectionsDocsPath(anotherCollectionDocPaths);

  CollectionReference _getCollectionByCollectionsDocsPath(
      Map<String, String?> collectionsDocsPath) {
    CollectionReference? finalCollection;
    String? prevLayerDoc;
    var count = 0;
    for (final element in collectionsDocsPath.entries) {
      if (count == 0) {
        if (element.value == null) {
          return _db.collection(element.key);
        } else {
          prevLayerDoc = element.value;
          finalCollection = _db.collection(element.key);
        }
      } else {
        finalCollection =
            finalCollection!.doc(prevLayerDoc).collection(element.key);
        if (element.value == null) {
          return finalCollection;
        } else {
          prevLayerDoc = element.value;
        }
      }
      count++;
    }
    return finalCollection!;
  }

  //DocumentReference getDoc(String docId) => _collection.doc(docId);

  Stream<QuerySnapshot> get getStream => _collection.snapshots();
}
