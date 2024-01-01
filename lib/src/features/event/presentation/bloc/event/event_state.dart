part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

//CREATE EVENT
class EventCreated extends EventState {}

class EventCreatedLoading extends EventState {}

class EventCreatedFailure extends EventState {}

//EVENT LOAD
class EventLoaded extends EventState {
  final List<Map<String, dynamic>> eventParticipants;

  const EventLoaded({required this.eventParticipants});
}

class EventLoading extends EventState {}

class EventFailure extends EventState {}
