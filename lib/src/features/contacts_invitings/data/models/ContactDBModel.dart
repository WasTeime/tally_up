import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/DBModel.dart';

class ContactDBModel extends DBModel {
  late final Map<String, String?> _collectionsDocsPath;

  ContactDBModel(String userUid)
      : super(pathToCollection: {'users': userUid, 'contacts': null}) {
    _collectionsDocsPath = {'users': userUid, 'contacts': null};
  }

  CollectionReference getContactsCollectionForAnotherUser(String userUid) {
    final anotherCollection = _collectionsDocsPath;
    anotherCollection['users'] = userUid;
    return super.getCollection(anotherCollectionDocPaths: anotherCollection);
  }
}
