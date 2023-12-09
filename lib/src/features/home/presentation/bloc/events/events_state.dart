part of 'events_bloc.dart';

abstract class EventsState {}

class EventsInitial extends EventsState {}

class EventsLoading extends EventsState {}

class EventsLoaded extends EventsState {}

class EventsFailure extends EventsState {}
