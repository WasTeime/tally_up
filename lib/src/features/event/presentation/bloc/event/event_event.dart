part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class CreateGroupEvent extends EventEvent {
  final String eventName;

  const CreateGroupEvent({
    required this.eventName,
  });
}

class LoadEvent extends EventEvent {}
