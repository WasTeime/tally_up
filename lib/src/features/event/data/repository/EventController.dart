import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/Controller.dart';
import 'package:tally_up/src/features/event/models/EventModel.dart';
import 'package:tally_up/src/features/group/data/repository/groupController.dart';

class EventController extends Controller {
  final _db = FirebaseFirestore.instance;
  final _groupController = GroupController();

  void createEvent(
    String eventName,
    DocumentReference groupRef,
  ) async {
    // var event = EventModel(eventName: eventName);
    // var groupParticipants =
    //     await _groupController.getGroupParticipantsRefs(groupRef: groupRef);

    // for (var participant in groupParticipants) {
    //   _db
    //       .collection('users')
    //       .doc(pa)
    //       .collection('groups')
    //       .doc(groupRef.id)
    //       .collection('events')
    //       .add(event.toJson());
    // }
    // _db
    //     .collection('users')
    //     .doc(getUserUid)
    //     .collection('groups')
    //     .doc(groupRef.id)
    //     .collection('events')
    //     .add(event.toJson());
  }

  void deleteEvent() {}

  void changeEvent() {}

  Future<Map<String, dynamic>> getEventData(DocumentReference eventRef) async =>
      await getDocFieldsByRef(eventRef);
}
