class ChequeModel {
  final String name;
  final double sum;
  final bool debtors;

  ChequeModel({
    required this.name,
    required this.sum,
    required this.debtors,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sum': sum,
      'debtors': debtors,
    };
  }
}
