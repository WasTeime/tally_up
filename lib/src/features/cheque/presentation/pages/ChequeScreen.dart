import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/core/layouts/mainLayout.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/cheque/presentation/bloc/bloc/cheque_bloc.dart';
import 'package:tally_up/src/features/cheque/presentation/widgets/view.dart';
import 'package:tally_up/src/features/event/presentation/widgets/FinalSumButtonWidget.dart';
import 'package:tally_up/src/features/group/presentation/widgets/CardWithNameAndParticipantsWidget.dart';

class ChequeScreen extends StatelessWidget {
  final DocumentReference chequeRef;

  const ChequeScreen({
    super.key,
    required this.chequeRef,
  });

  @override
  Widget build(BuildContext context) {
    final ChequeBloc chequeBloc = ChequeBloc(chequeRef: chequeRef);
    var debt = ValueNotifier(0.0);

    return BlocProvider.value(
      value: chequeBloc..add(LoadCheque(chequeRef: chequeRef)),
      child: BlocBuilder<ChequeBloc, ChequeState>(
        builder: (context, state) {
          if (state is ChequeLoaded) {
            var eventData = state.data['event_data'];
            var chequeData = state.data['cheque_data']['data'];
            var chequeProductsList = state.data['cheque_data']['products'];

            return MainLayout(
              appBarWidget: AppBarWidget.withEditButton(
                enableEditButton: () => (),
                enableBackButton: () => context.pop(),
                titleWidget: CardWithNameAndParticipantsWidget.forEvent(
                  cardIcon: Icons.abc,
                  titleText: eventData['name'],
                  peopleCount: eventData['participants_count'],
                ),
              ),
              contentWidget: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Text('${chequeData['shop_name']}'),
                              Text('${chequeData['shop_address']}'),
                              Text('${chequeData['date_time']}'),
                            ],
                          ),
                          Container(
                            decoration: DottedDecoration(),
                          ),
                          Table(
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(30),
                              1: FlexColumnWidth(),
                              2: FixedColumnWidth(60),
                              3: FlexColumnWidth(),
                              4: FixedColumnWidth(50),
                            },
                            children: <TableRow>[
                              const TableRow(
                                children: [
                                  Center(child: Text('№')),
                                  Text('Название'),
                                  Text('Цена'),
                                  Text('Кол-во'),
                                  Text('Сумма'),
                                ],
                              ),
                              for (var product in chequeProductsList)
                                TableRow(
                                  children: [
                                    Center(child: Text('${product['id']}')),
                                    Text(product['name']),
                                    Text("${product['price']}"),
                                    Card(
                                      child: Row(
                                        children: [
                                          //todo при зажатии чтобы быстро увеличивалось
                                          IconButton(
                                            onPressed: () {
                                              if (product['quantity'].value <
                                                  product[
                                                      'original_quantity']) {
                                                product['quantity'].value++;
                                                debt.value -= product['price'];
                                              }
                                            },
                                            icon: const Icon(Icons.remove),
                                          ),
                                          ValueListenableBuilder(
                                            valueListenable:
                                                product['quantity'],
                                            builder: (context, int quantity,
                                                    child) =>
                                                Text("$quantity"),
                                          ),
                                          //todo при зажатии чтобы быстро уменьшалось
                                          IconButton(
                                            onPressed: () {
                                              if (product['quantity'].value >
                                                  0) {
                                                product['quantity'].value--;
                                                debt.value += product['price'];
                                              }
                                            },
                                            icon: const Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: product['quantity'],
                                      builder: (context, int quantity, child) =>
                                          Text(
                                              '${quantity * product['price']}'),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          Container(decoration: DottedDecoration()),
                          ChequeRowInfoFieldWidget(
                            text: "Итого:",
                            value: chequeData['final_sum'].toString(),
                          ),
                          ChequeRowInfoFieldWidget(
                            text: "Наличные",
                            value: chequeData['cash_sum'].toString(),
                          ),
                          ChequeRowInfoFieldWidget(
                            text: "Карта",
                            value: chequeData['card_sum'].toString(),
                          ),
                          Container(decoration: DottedDecoration()),
                          ChequeRowInfoFieldWidget(
                            text: "ФН",
                            value: chequeData['fn'].toString(),
                          ),
                          ChequeRowInfoFieldWidget(
                            text: "ФД",
                            value: chequeData['fd'].toString(),
                          ),
                          ChequeRowInfoFieldWidget(
                            text: "ФПД",
                            value: chequeData['fpd'].toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: debt,
                    builder: (__, value, _) => FinalSumButtonWidget(
                      title: "Мой долг",
                      sum: value < 0 ? "0.0" : value.toStringAsFixed(2),
                      buttonText: "Перевести",
                      onButtonPressedEvent: () => (),
                    ),
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
