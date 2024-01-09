import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tally_up/src/core/layouts/mainLayout.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/cheque/presentation/bloc/bloc/cheque_bloc.dart';
import 'package:tally_up/src/features/event/presentation/bloc/event/event_bloc.dart';
import 'package:tally_up/src/features/event/presentation/widgets/FinalSumButtonWidget.dart';
import 'package:tally_up/src/features/event/presentation/widgets/cheques_list/ChequesListWidget.dart';
import 'package:tally_up/src/features/group/presentation/widgets/CardWithNameAndParticipantsWidget.dart';

class EventScreen extends StatefulWidget {
  final DocumentReference eventRef;

  const EventScreen({
    super.key,
    required this.eventRef,
  });

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late final EventBloc _eventBloc;
  late final ChequeBloc _chequeBloc;

  @override
  void initState() {
    super.initState();
    _eventBloc = EventBloc(
      groupRef: widget.eventRef.parent.parent as DocumentReference,
      eventRef: widget.eventRef,
    );
    _chequeBloc = ChequeBloc(eventRef: widget.eventRef);
  }

  double getFinalSumForAllCheques(List<Map<String, dynamic>> chequesList) {
    double finalSum = 0;
    for (var cheque in chequesList) {
      finalSum += cheque['final_sum'];
    }
    return finalSum;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider.value(
      value: _eventBloc,
      child: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if (state is EventLoaded) {
            var eventData = state.data["data"];
            List<Map<String, dynamic>> chequesList = state.data["cheques"];
            return MainLayout(
              appBarWidget: AppBarWidget.withEditButton(
                enableEditButton: () => print(''),
                enableBackButton: () =>
                    context.canPop() ? context.pop() : context.go('/'),
                titleWidget: CardWithNameAndParticipantsWidget.forEvent(
                  cardIcon: Icons.abc,
                  titleText: eventData['name'],
                  peopleCount: eventData['participants_count'],
                ),
              ),
              subAppBarWidget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat('dd.MM.yyyy').format(
                    (eventData['created_at'] as Timestamp).toDate(),
                  ),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0079FF),
                  ),
                ),
              ),
              //todo сделать чтобы высота была до кнопки типо через media query и вот это вот всё, чтобы короче динамически было
              contentWidget: Container(
                height: 500,
                child: chequesList.isNotEmpty
                    ? ChequesListWidget(cheques: chequesList)
                    : const Center(child: Text("У вас пока нет чеков")),
              ),
              underContentButtonWidget: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => context.push(
                      '/createCheque',
                      extra: widget.eventRef,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(7),
                      backgroundColor: const Color(0xFF0079FF),
                      foregroundColor: Colors.blue,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 45,
                    ),
                  ),
                  if (chequesList.isNotEmpty)
                    FinalSumButtonWidget(
                      title: "ИТОГО",
                      sum: getFinalSumForAllCheques(chequesList).toString(),
                      buttonText: "разделить\nпоровну",
                      onButtonPressedEvent: () => {},
                    )
                ],
              ),
            );
          }
          return const LoadingOnWhiteBackgroundWidget();
        },
      ),
    );
  }
}
