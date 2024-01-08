part of 'cheque_bloc.dart';

abstract class ChequeEvent extends Equatable {
  const ChequeEvent();

  @override
  List<Object> get props => [];
}

class LoadCheque extends ChequeEvent {}

class CreateCheque extends ChequeEvent {}
