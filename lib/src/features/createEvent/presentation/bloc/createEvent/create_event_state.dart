part of 'create_event_bloc.dart';

abstract class CreateEventState {}

class CreateEventInitial extends CreateEventState {}

class CreateEventLoading extends CreateEventState {}

class CreateEventLoaded extends CreateEventState {
  DocumentReference createdGroupRef;

  CreateEventLoaded(this.createdGroupRef);
}

class CreateEventFailure extends CreateEventState {}
