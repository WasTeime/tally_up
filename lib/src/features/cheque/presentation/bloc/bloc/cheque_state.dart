part of 'cheque_bloc.dart';

abstract class ChequeState extends Equatable {
  const ChequeState();

  @override
  List<Object> get props => [];
}

class ChequeInitial extends ChequeState {}

//LOAD CHEQUE
class ChequeLoading extends ChequeState {}

class ChequeLoaded extends ChequeState {
  final Map<String, dynamic> data;

  const ChequeLoaded({required this.data});
}

class ChequeFailure extends ChequeState {}

//CREATE CHEQUE
class ChequeCreating extends ChequeState {}

class ChequeCreated extends ChequeState {}

class ChequeCreatingFailure extends ChequeState {}
