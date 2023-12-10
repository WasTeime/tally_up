import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/DBModel.dart';

class FriendInvitationDBModel extends DBModel {
  late final Map<String, String?> _collectionsDocsPath;

  FriendInvitationDBModel(String userUid)
      : super(
            pathToCollection: {'users': userUid, 'friends_invitations': null}) {
    _collectionsDocsPath = {'users': userUid, 'friends_invitations': null};
  }

  CollectionReference getFriendsInvitationsCollectionForAnotherUser(
      String userUid) {
    final anotherCollection = _collectionsDocsPath;
    anotherCollection['users'] = userUid;
    return super.getCollection(anotherCollectionDocPaths: anotherCollection);
  }
}
