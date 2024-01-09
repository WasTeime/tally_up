part of 'cheque_bloc.dart';

abstract class ChequeEvent extends Equatable {
  const ChequeEvent();

  @override
  List<Object> get props => [];
}

class LoadCheque extends ChequeEvent {
  final DocumentReference chequeRef;

  const LoadCheque({required this.chequeRef});
}

class CreateCheque extends ChequeEvent {
  final String chequeQRRaw;

  const CreateCheque({required this.chequeQRRaw});
}
