import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/DBModel.dart';

class GroupsDBModel extends DBModel {
  late final Map<String, String?> _collectionsDocsPath;

  GroupsDBModel(String userUid)
      : super(pathToCollection: {'users': userUid, 'groups': null}) {
    _collectionsDocsPath = {'users': userUid, 'groups': null};
  }

  CollectionReference getCollectionForAnotherUser(String userUid) {
    final anotherCollection = _collectionsDocsPath;
    anotherCollection['users'] = userUid;
    return super.getCollection(anotherCollectionDocPaths: anotherCollection);
  }
}
