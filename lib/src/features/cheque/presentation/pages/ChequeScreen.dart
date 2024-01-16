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
    final theme = Theme.of(context);
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
                  Container(
                    color: Colors.white,
                    width: 370,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                  textAlign: TextAlign.center,
                                  '${chequeData['shop_name']}',
                                  style: theme.textTheme.displayLarge
                                      ?.copyWith(fontSize: 13)),
                              Text(
                                  textAlign: TextAlign.center,
                                  '${chequeData['shop_address']}',
                                  style: theme.textTheme.displayLarge
                                      ?.copyWith(fontSize: 13)),
                              Text(
                                  textAlign: TextAlign.center,
                                  '${chequeData['date_time']}',
                                  style: theme.textTheme.displayLarge
                                      ?.copyWith(fontSize: 13)),
                              SizedBox(
                                height: 7,
                              )
                            ],
                          ),
                          Container(
                            decoration: DottedDecoration(),
                          ),
                          Table(
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(20),
                              1: FlexColumnWidth(),
                              2: FixedColumnWidth(60),
                              3: FlexColumnWidth(),
                              4: FixedColumnWidth(50),
                            },
                            children: <TableRow>[
                              TableRow(
                                children: [
                                  Center(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      '№',
                                      style: theme.textTheme.headlineMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                    ),
                                  ),
                                  Text(
                                    'Название',
                                    style: theme.textTheme.headlineMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                  ),
                                  Text(
                                    'Цена',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.headlineMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                  ),
                                  Text(
                                    'Кол-во',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.headlineMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                  ),
                                  Text(
                                    'Сумма',
                                    style: theme.textTheme.headlineMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                  ),
                                ],
                              ),
                              for (var product in chequeProductsList)
                                TableRow(
                                  children: [
                                    Center(
                                        child: Text('${product['id']}',
                                            style: theme
                                                .textTheme.headlineMedium
                                                ?.copyWith(fontSize: 13))),
                                    Text(product['name'],
                                        style: theme.textTheme.headlineMedium
                                            ?.copyWith(fontSize: 13)),
                                    Text(
                                        textAlign: TextAlign.center,
                                        "${product['price']}",
                                        style: theme.textTheme.headlineMedium
                                            ?.copyWith(fontSize: 13)),
                                    Row(
                                      children: [
                                        //todo при зажатии чтобы быстро увеличивалось
                                        IconButton(
                                          onPressed: () {
                                            if (product['quantity'].value >
                                                product['original_quantity']) {
                                              product['quantity'].value--;
                                              debt.value -= product['price'];
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Color(0xFF0079FF),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ValueListenableBuilder(
                                            valueListenable:
                                                product['quantity'],
                                            builder: (context, int quantity,
                                                    child) =>
                                                Text(
                                              "$quantity",
                                              style: theme
                                                  .textTheme.headlineMedium
                                                  ?.copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                        ),

                                        //todo при зажатии чтобы быстро уменьшалось
                                        IconButton(
                                          onPressed: () {
                                            if (product['quantity'].value > 0) {
                                              product['quantity'].value++;
                                              debt.value += product['price'];
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: Color(0xFF0079FF),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: product['quantity'],
                                      builder: (context, int quantity, child) =>
                                          Text(
                                        textAlign: TextAlign.center,
                                        '${quantity * product['price']}',
                                        style: theme.textTheme.headlineMedium
                                            ?.copyWith(fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Container(decoration: DottedDecoration()),
                          ChequeRowInfoFieldWidget(
                            text: "Итого:",
                            textStyle: theme.textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 22),
                            value: chequeData['final_sum'].toString(),
                          ),
                          ChequeRowInfoFieldWidget(
                            text: "Наличные",
                            textStyle: theme.textTheme.headlineMedium!
                                .copyWith(fontSize: 13),
                            value: chequeData['cash_sum'].toString(),
                          ),
                          ChequeRowInfoFieldWidget(
                            text: "Карта",
                            textStyle: theme.textTheme.headlineMedium!
                                .copyWith(fontSize: 13),
                            value: chequeData['card_sum'].toString(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(decoration: DottedDecoration()),
                          ChequeRowInfoFieldWidget(
                            text: "ФН",
                            textStyle: theme.textTheme.headlineMedium!
                                .copyWith(fontSize: 13),
                            value: chequeData['fn'].toString(),
                          ),
                          ChequeRowInfoFieldWidget(
                            text: "ФД",
                            textStyle: theme.textTheme.headlineMedium!
                                .copyWith(fontSize: 13),
                            value: chequeData['fd'].toString(),
                          ),
                          ChequeRowInfoFieldWidget(
                            text: "ФПД",
                            textStyle: theme.textTheme.headlineMedium!
                                .copyWith(fontSize: 13),
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
