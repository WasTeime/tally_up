import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/Controller.dart';
import 'package:tally_up/src/features/home/data/models/GroupsDBModel.dart';

class GroupController extends Controller {
  late final GroupsDBModel _groupsDBModel;
  late final DocumentReference _groupRef;

  GroupController({required DocumentReference groupRef}) : super() {
    _groupRef = groupRef;
    _groupsDBModel = GroupsDBModel(super.getUserUid);
  }

  Future<Map<String, dynamic>> getGroupDataWithEvents(
      QuerySnapshot querySnapshot) async {
    Map<String, dynamic> data = {};
    data = await getDocFieldsByRef(_groupRef);
    data['events'] = await getCollectionDocs(querySnapshot);
    return data;
  }

  Stream<QuerySnapshot> get getGroupEventsListStream => _groupsDBModel
      .getCollection()
      .doc(_groupRef.id)
      .collection('events')
      .snapshots();
}
