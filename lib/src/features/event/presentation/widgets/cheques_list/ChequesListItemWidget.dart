import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChequesListItemWidget extends StatelessWidget {
  final DocumentReference chequeRef;
  final String chequeName;
  final double sum;

  const ChequesListItemWidget({
    super.key,
    required this.chequeName,
    required this.sum,
    required this.chequeRef,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/cheque', extra: chequeRef),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(4, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            const Expanded(
              flex: 2,
              child: Image(
                image: AssetImage('assets/images/cheque.png'),
                width: 40,
                height: 40,
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(chequeName), // Номер чека
                  Text(sum.toString()), // Сумма чека в рублях
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
