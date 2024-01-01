import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/Controller.dart';
import 'package:tally_up/src/features/home/data/models/GroupsDBModel.dart';
import 'package:tally_up/src/features/home/domain/models/GroupModel.dart';

class CreateGroupController extends Controller {
  late final GroupsDBModel _groupsDBModel;

  CreateGroupController() : super() {
    _groupsDBModel = GroupsDBModel(super.getUserUid);
  }

  Future<DocumentReference> createGroup(
    String groupName,
    List<DocumentReference> groupParticipants,
  ) async {
    final creatorGroupModel = GroupModel(
        groupName: groupName,
        participants: groupParticipants,
        role: Role.creator);
    final memberGroupModel = GroupModel(
        groupName: groupName,
        participants: groupParticipants,
        role: Role.participant);
    String groupDocId = "";
    for (final participant in groupParticipants) {
      if (participant == groupParticipants.first) {
        groupDocId = await participant
            .collection('groups')
            .add(memberGroupModel.toJson())
            .then((docRef) => docRef.id);
      } else {
        await participant
            .collection('groups')
            .doc(groupDocId)
            .set(memberGroupModel.toJson());
      }
    }
    DocumentReference createdGroupRef = await _groupsDBModel
        .getCollection()
        .doc(groupDocId)
        .set(creatorGroupModel.toJson());
    return createdGroupRef;
  }
}
