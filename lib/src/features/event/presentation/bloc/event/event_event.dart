part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class CreateGroupEventEvent extends EventEvent {
  final String groupName;
  final List<DocumentReference> groupParticipants;

  const CreateGroupEventEvent({
    required this.groupName,
    required this.groupParticipants,
  });
}

class LoadEvent extends EventEvent {}
