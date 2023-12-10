import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/DBModel.dart';

class FriendDBModel extends DBModel {
  late final Map<String, String?> _collectionsDocsPath;

  FriendDBModel(String userUid)
      : super(pathToCollection: {'users': userUid, 'friends': null}) {
    _collectionsDocsPath = {'users': userUid, 'friends': null};
  }

  CollectionReference getFriendsCollectionForAnotherUser(String userUid) {
    final anotherCollection = _collectionsDocsPath;
    anotherCollection['users'] = userUid;
    return super.getCollection(anotherCollectionDocPaths: anotherCollection);
  }
}
