import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tally_up/src/core/data/Controller.dart';
import 'package:tally_up/src/features/event/domain/models/EventModel.dart';

class EventController extends Controller {
  final _db = FirebaseFirestore.instance;

  void createEvent(String eventName, DocumentReference groupRef,
      List<DocumentReference> groupParticipants) {
    var event = EventModel(eventName: eventName);
    for (var participant in groupParticipants) {
      _db
          .collection('users')
          .doc(getUserUid)
          .collection('groups')
          .doc(groupRef.id)
          .collection('events')
          .add(event.toJson());
    }
    _db
        .collection('users')
        .doc(getUserUid)
        .collection('groups')
        .doc(groupRef.id)
        .collection('events')
        .add(event.toJson());
  }

  void deleteEvent() {}

  void changeEvent() {}

  void getEventData() {}
}
