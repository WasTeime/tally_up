import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/Controller.dart';
import 'package:tally_up/src/features/group/data/models/GroupsDBModel.dart';
import 'package:tally_up/src/features/group/data/repository/groupController.dart';

class GroupsController extends Controller {
  final _groupController = GroupController();
  late final GroupsDBModel _groupsDBModel;

  GroupsController() {
    _groupsDBModel = GroupsDBModel(super.getUserUid);
  }

  Stream<QuerySnapshot> get getGroupsListStream => _groupsDBModel.getStream;

  Future<List<Map<String, dynamic>>> getGroupsList(
    QuerySnapshot querySnapshot,
  ) async {
    List<Map<String, dynamic>> docs = [];

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data =
          await _groupController.getGroupData(groupRef: doc.reference);
      //добавляем group_ref к data, чтобы потом при нажатии на карточку группы понимать
      //на какую группу нажали (для того, чтобы backend понимал куда данные добавлять)
      data['group_ref'] = doc.reference;

      docs.add(data);
    }

    return docs;
  }
}
