import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    List<Map<dynamic, dynamic>> list = [
      {
        'id': 1,
        'name': 'fdasf',
        'original_quantity': 2,
        'quantity': ValueNotifier(2),
        'price': 20.0,
      },
      {
        'id': 2,
        'name': 'adsffsdafsd',
        'original_quantity': 20,
        'quantity': ValueNotifier(20),
        'price': 5.0,
      },
    ];

    return MainLayout(
      appBarWidget: AppBarWidget.withEditButton(
        enableEditButton: () => (),
        enableBackButton: () => context.go('/'),
        titleWidget: const CardWithNameAndParticipantsWidget.forEvent(
          cardIcon: Icons.abc,
          titleText: 'sadasd',
          peopleCount: 12,
        ),
      ),
      contentWidget: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Column(
                  children: [
                    Text('djafkl'),
                    Text('djafkl'),
                    Text('djafkl'),
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
                    for (var product in list)
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
                                        product['original_quantity']) {
                                      product['quantity'].value++;
                                    }
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: product['quantity'],
                                  builder: (context, int quantity, child) =>
                                      Text("$quantity"),
                                ),
                                //todo при зажатии чтобы быстро уменьшалось
                                IconButton(
                                  onPressed: () {
                                    if (product['quantity'].value > 0) {
                                      product['quantity'].value--;
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
                                Text('${quantity * product['price']}'),
                          ),
                        ],
                      ),
                  ],
                ),
                Container(
                  decoration: DottedDecoration(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Итого:'),
                    Text('sdfsdf'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Наличные'),
                    Text('sdfsdf'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Карта'),
                    Text('sdfsdf'),
                  ],
                ),
                Container(
                  decoration: DottedDecoration(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ФН'),
                    Text('sdfsdf'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ФД'),
                    Text('sdfsdf'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ФПД'),
                    Text('sdfsdf'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
