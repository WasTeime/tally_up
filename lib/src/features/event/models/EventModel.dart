class EventModel {
  final String eventName;
  final double? finalSum;
  final DateTime createdDate = DateTime.now();

  EventModel({
    required this.eventName,
    this.finalSum,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': eventName,
      'final_sum': finalSum,
      'created_at': createdDate,
    };
  }
}
