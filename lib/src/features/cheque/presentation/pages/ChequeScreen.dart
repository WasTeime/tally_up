import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally_up/src/core/layouts/mainLayout.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/cheque/presentation/bloc/bloc/cheque_bloc.dart';
import 'package:tally_up/src/features/group/presentation/widgets/CardWithNameAndParticipantsWidget.dart';

class ChequeScreen extends StatelessWidget {
  final DocumentReference chequeRef;

  const ChequeScreen({
    super.key,
    required this.chequeRef,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBarWidget: AppBarWidget.withEditButton(
        enableEditButton: () => (),
        enableBackButton: () => (),
        titleWidget: CardWithNameAndParticipantsWidget.forEvent(
          cardIcon: Icons.abc,
          titleText: 'sadasd',
          peopleCount: 2,
        ),
      ),
      contentWidget: Center(
        child: Card(
          child: Text('fds'),
        ),
      ),
    );
  }
}
