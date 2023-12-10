import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/Controller.dart';
import 'package:tally_up/src/features/home/data/models/GroupsDBModel.dart';

class GroupsController extends Controller {
  late final GroupsDBModel _groupsDBModel;

  GroupsController() {
    _groupsDBModel = GroupsDBModel(super.getUserUid);
  }

  Stream<QuerySnapshot> get getGroupsListStram => _groupsDBModel.getStream;

  @override
  Future<List<Map<String, dynamic>>> getCollectionDocs(
      QuerySnapshot querySnapshot) async {
    List<Map<String, dynamic>> docsList = [];
    for (var doc in querySnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      data['group_ref'] = doc.reference;
      docsList.add(data);
    }
    return docsList;
  }
}
