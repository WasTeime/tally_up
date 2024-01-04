import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/Controller.dart';
import 'package:tally_up/src/features/group/data/models/GroupsDBModel.dart';
import 'package:tally_up/src/features/group/models/GroupModel.dart';

enum Role { participant, creator }

class GroupController extends Controller {
  late final GroupsDBModel _groupsDBModel;

  GroupController() : super() {
    _groupsDBModel = GroupsDBModel(super.getUserUid);
  }

  Stream<QuerySnapshot> getGroupEventsListStream({
    required DocumentReference groupRef,
  }) =>
      _groupsDBModel
          .getCollection()
          .doc(groupRef.id)
          .collection('events')
          .snapshots();

  Future<Map<String, dynamic>> getGroupData({
    required DocumentReference groupRef,
  }) async {
    Map<String, dynamic> data = {};
    data.addAll(await getDocFieldsByRef(groupRef));
    data.addAll({
      'participants': await getGroupParticipantsRefs(groupRef: groupRef),
      'events': await getListGroupEvents(groupRef: groupRef),
    });
    return data;
  }

  //получаем участников группы (список ссылок на пользователей)
  Future<List<DocumentReference>> getGroupParticipantsRefs({
    required DocumentReference groupRef,
  }) async {
    List<DocumentReference> groupParticipantsRefs = [];
    await db
        .collection('groups')
        .doc(groupRef.id)
        .collection('participants')
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.forEach((DocumentSnapshot doc) {
              groupParticipantsRefs.add(db.collection('users').doc(doc.id));
            }));
    return groupParticipantsRefs;
  }

  Future<List<Map<String, dynamic>>> getListGroupEvents({
    required DocumentReference groupRef,
  }) async {
    return await db
        .collection('groups')
        .doc(groupRef.id)
        .collection('events')
        .get()
        .then((querySnapshot) => getCollectionDocs(querySnapshot));
  }

  Future<DocumentReference> createGroup(
    String groupName,
    List<DocumentReference> groupParticipants, //без создателя группы
  ) async {
    final createdGroupModel = GroupModel(groupName: groupName);

    DocumentReference createdGroupRef =
        await _groupsDBModel.getCollection().add(createdGroupModel.toJson());

    //добавляем создателя группы в paricipants
    await createdGroupRef
        .collection('participants')
        .doc(getUserUid)
        .set({'role': Role.creator.name});
    await db
        .collection('users')
        .doc(getUserUid)
        .collection('groups')
        .doc(createdGroupRef.id)
        .set({});

    //добавляем участников группы в paricipants
    for (var participant in groupParticipants) {
      await createdGroupRef
          .collection('participants')
          .doc(participant.id)
          .set({'role': Role.participant.name});
      await participant.collection('groups').doc(createdGroupRef.id).set({});
    }

    return createdGroupRef;
  }
}
