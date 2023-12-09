import 'package:flutter_bloc/flutter_bloc.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(EventsInitial()) {
    on<LoadEvents>((event, emit) {
      // TODO: implement event handler
    });
  }
}
