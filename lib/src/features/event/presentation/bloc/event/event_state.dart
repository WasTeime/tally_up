part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

//CREATE EVENT
class EventCreated extends EventState {}

class EventCreating extends EventState {}

class EventCreateFailure extends EventState {}

//EVENT LOAD
class EventLoaded extends EventState {
  final Map<String, dynamic> data;

  const EventLoaded({required this.data});
}

class EventLoading extends EventState {}

class EventFailure extends EventState {}
