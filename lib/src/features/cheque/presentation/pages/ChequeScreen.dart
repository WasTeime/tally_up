import 'package:flutter/material.dart';

class ChequeScreen extends StatelessWidget {
  final String chequeFNSInfoFromScanner;

  const ChequeScreen({
    super.key,
    required this.chequeFNSInfoFromScanner,
  });

  @override
  Widget build(BuildContext context) {
    print(chequeFNSInfoFromScanner);
    return const Placeholder();
  }
}
