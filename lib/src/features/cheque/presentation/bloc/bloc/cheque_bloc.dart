import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:tally_up/src/features/cheque/data/repository/chequeController.dart';

part 'cheque_event.dart';
part 'cheque_state.dart';

class ChequeBloc extends Bloc<ChequeEvent, ChequeState> {
  final _chequeController = ChequeController();

  ChequeBloc({DocumentReference? chequeRef}) : super(ChequeInitial()) {
    on<CreateCheque>((event, emit) {});

    on<LoadCheque>((event, emit) {});
  }
}
