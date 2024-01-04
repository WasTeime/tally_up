import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tally_up/src/features/event/data/repository/eventController.dart';
import 'package:tally_up/src/features/group/data/repository/groupController.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final _eventController = EventController();
  late final GroupController? _groupController;

  EventBloc({required DocumentReference groupRef}) : super(EventInitial()) {
    _groupController = GroupController();

    on<CreateGroupEvent>((event, emit) {
      _eventController.createEvent(event.eventName, groupRef);
    });

    on<LoadEvent>((event, emit) async {
      // emit(EventLoading());
      // if (_groupController != null) {
      //   await _groupController!
      //       .getGroupParticipants(groupRef: groupRef)
      //       .then((data) {
      //     for (var element in data) {
      //       element['check'] = ValueNotifier(false);
      //     }
      //     emit(EventLoaded(eventParticipants: data));
      //   });
      // }
    });
  }
}
