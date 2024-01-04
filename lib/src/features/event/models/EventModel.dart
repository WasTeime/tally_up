import 'package:tally_up/src/features/cheque/domain/models/ChequeModel.dart';

class EventModel {
  final String eventName;
  final List<ChequeModel>? chequesList;
  final double? finalSum;
  final DateTime createdDate = DateTime.now();

  EventModel({
    required this.eventName,
    this.chequesList,
    this.finalSum,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': eventName,
      'cheques': chequesList,
      'final_sum': finalSum,
      'created_at': createdDate,
    };
  }
}
