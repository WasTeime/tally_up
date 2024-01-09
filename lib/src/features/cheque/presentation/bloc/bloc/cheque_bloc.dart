import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:tally_up/src/features/cheque/data/repository/chequeController.dart';
import 'package:tally_up/src/features/event/data/repository/eventController.dart';

part 'cheque_event.dart';
part 'cheque_state.dart';

class ChequeBloc extends Bloc<ChequeEvent, ChequeState> {
  final _chequeController = ChequeController();
  final _eventController = EventController();

  ChequeBloc({
    DocumentReference? eventRef,
    DocumentReference? chequeRef,
  }) : super(ChequeInitial()) {
    on<CreateCheque>((event, emit) async {
      emit(ChequeCreating());
      await _chequeController
          .createCheque(
            eventRef: eventRef!,
            chequeQRRaw: event.chequeQRRaw,
          )
          .then((value) => ChequeCreated());
    });

    on<LoadCheque>((event, emit) async {
      emit(ChequeLoading());
      await _chequeController
          .getChequeData(chequeRef: event.chequeRef)
          .then((chequeData) async {
        Map<String, dynamic> data = {
          'event_data':
              await _eventController.getEventNameWithCountParticipants(
            eventRef: chequeRef!.parent.parent as DocumentReference,
          ),
          'cheque_data': chequeData,
        };
        emit(ChequeLoaded(data: data));
      });
    });
  }
}
