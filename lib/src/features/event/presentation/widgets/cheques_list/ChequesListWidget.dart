import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally_up/src/features/event/presentation/widgets/cheques_list/ChequesListItemWidget.dart';

class ChequesListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> cheques;

  const ChequesListWidget({
    super.key,
    required this.cheques,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          maxCrossAxisExtent: 200,
        ),
        itemCount: cheques.length,
        itemBuilder: (BuildContext context, int index) {
          return ChequesListItemWidget(
            chequeRef: cheques[index]['cheque_ref'] as DocumentReference,
            chequeName: "Чек ${index + 1}",
            sum: cheques[index]['final_sum'],
          );
        },
      ),
    );
  }
}
