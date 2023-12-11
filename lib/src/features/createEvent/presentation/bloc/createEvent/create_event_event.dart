part of 'create_event_bloc.dart';

abstract class CreateEventEvent {}

class CreateEvent extends CreateEventEvent {
  final String groupName;
  final List<DocumentReference> groupParticipants;

  CreateEvent(this.groupName, this.groupParticipants);
}
