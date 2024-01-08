import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:tally_up/src/features/event/data/repository/eventController.dart';
part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final _eventController = EventController();

  EventBloc({required DocumentReference groupRef, DocumentReference? eventRef})
      : super(EventInitial()) {
    if (eventRef != null) {
      _eventController.getChequesListStream(eventRef: eventRef).listen(
            (QuerySnapshot querySnapshot) => add(
              LoadEvent(querySnapshot: querySnapshot),
            ),
          );
    }

    on<CreateGroupEvent>((event, emit) async {
      emit(EventCreating());
      await _eventController
          .createEvent(event.eventName, groupRef)
          .then((value) => emit(EventCreated()));
    });

    on<EventEvent>((event, emit) {});

    on<LoadEvent>((event, emit) async {
      emit(EventLoading());
      await _eventController
          .getEventFullData(
            chequesCollectionSnapshot: event.querySnapshot,
            groupRef: groupRef,
            eventRef: eventRef!,
          )
          .then((data) => emit(EventLoaded(data: data)));
    });
  }
}
