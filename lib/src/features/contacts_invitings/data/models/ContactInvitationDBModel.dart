import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/DBModel.dart';

class ContactInvitationDBModel extends DBModel {
  late final Map<String, String?> _collectionsDocsPath;

  ContactInvitationDBModel(String userUid)
      : super(pathToCollection: {
          'users': userUid,
          'contacts_invitations': null,
        }) {
    _collectionsDocsPath = {'users': userUid, 'contacts_invitations': null};
  }

  CollectionReference getContactsInvitationsCollectionForAnotherUser(
      String userUid) {
    final anotherCollection = _collectionsDocsPath;
    anotherCollection['users'] = userUid;
    return super.getCollection(anotherCollectionDocPaths: anotherCollection);
  }
}
