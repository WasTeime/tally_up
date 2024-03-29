import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/Controller.dart';
import 'package:tally_up/src/features/event/models/EventModel.dart';
import 'package:tally_up/src/features/group/data/repository/groupController.dart';

class EventController extends Controller {
  final _groupController = GroupController();

  Stream<QuerySnapshot> getChequesListStream({
    required DocumentReference eventRef,
  }) =>
      eventRef.collection('cheques').snapshots();

  //todo добавить try catch
  Future<void> createEvent(
    String eventName,
    DocumentReference groupRef,
  ) async {
    var event = EventModel(eventName: eventName);
    await groupRef.collection('events').add(event.toJson());
  }

  void deleteEvent() {}

  void changeEvent() {}

  Future<List<Map<String, dynamic>>> getChequesList(
    QuerySnapshot querySnapshot,
  ) async {
    List<Map<String, dynamic>> docsList = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data.addAll({'cheque_ref': doc.reference});
      docsList.add(data);
    }
    return docsList;
  }

  Future<Map<String, dynamic>> getEventNameWithCountParticipants({
    required DocumentReference eventRef,
  }) async {
    var groupRef = eventRef.parent.parent as DocumentReference;
    return {
      'name': await getDocFieldsByRef(eventRef).then((data) => data['name']),
      'participants_count':
          await _groupController.getCountParticipants(groupRef: groupRef),
    };
  }

  //данные по мероприятию вместе с количеством участников из коллекции "participants" и списком чеков из коллекции "cheques"
  Future<Map<String, dynamic>> getEventFullData({
    required QuerySnapshot chequesCollectionSnapshot,
    required DocumentReference groupRef,
    required DocumentReference eventRef,
  }) async {
    Map<String, dynamic> data = {
      "data": await getEventData(eventRef).then(
        (data) async {
          data.addAll({
            "participants_count":
                await _groupController.getCountParticipants(groupRef: groupRef)
          });
          return data;
        },
      ),
      "cheques": await getChequesList(chequesCollectionSnapshot),
    };
    return data;
  }

  Future<Map<String, dynamic>> getEventData(DocumentReference eventRef) async =>
      await getDocFieldsByRef(eventRef);
}
