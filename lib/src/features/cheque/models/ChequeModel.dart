class ChequeModel {
  final String shopName;
  final String shopAddress;
  final String chequeDateTime;
  final double cashSum;
  final double cardSum;
  final double finalSum;
  final String fn;
  final String fd;
  final String fpd;
  //final String qrCode;

  ChequeModel({
    required this.shopName,
    required this.shopAddress,
    required this.chequeDateTime,
    required this.cashSum,
    required this.cardSum,
    required this.finalSum,
    required this.fn,
    required this.fd,
    required this.fpd,
  });

  Map<String, dynamic> toJson() {
    return {
      'shop_name': shopName,
      'shop_address': shopAddress,
      'date_time': chequeDateTime,
      'cash_sum': cashSum,
      'card_sum': cardSum,
      'final_sum': finalSum,
      'fn': fn,
      'fd': fd,
      'fpd': fpd,
    };
  }
}
