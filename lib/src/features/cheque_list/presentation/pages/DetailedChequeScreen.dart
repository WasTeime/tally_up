import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tally_up/src/features/cheque_list/presentation/widgets/NameEventWidget.dart';
import 'package:tally_up/src/features/cheque_list/domain/models/ProductModel.dart';
import 'package:tally_up/src/features/cheque_list/presentation/widgets/view.dart';

import '../../../../core/widgets/view.dart';

class DetailedChequeScreen extends StatefulWidget {
  const DetailedChequeScreen({super.key});

  @override
  State<DetailedChequeScreen> createState() => _DetailedChequeScreenState();
}

class _DetailedChequeScreenState extends State<DetailedChequeScreen> {
  final List<Product> products = [
    Product(1, "Чоколадка Милка", ValueNotifier(1), 54),
    Product(2, "CoolCola", ValueNotifier(1), 100),
    Product(3, "Кофе", ValueNotifier(1), 20),
  ];

  Widget _namberCheque() {
    final theme = Theme.of(context);
    return Container(
        margin: EdgeInsets.only(top: 115, bottom: 20),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text('Чек #0228', style: theme.textTheme.headlineLarge),
        ));
  }

  Widget _creator() {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 115, bottom: 165, left: 12),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(children: [
          Text('Создатель:',
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontSize: 15, fontWeight: FontWeight.w500)),
          SizedBox(
            width: 15,
          ),
          Text('Бог',
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontSize: 14, fontWeight: FontWeight.w900)),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BottomNavigationBarWidget(),
          NameEventWidget(name: 'Мероприятие Мяу', people: '5 участников'),
          _namberCheque(),
          ChequeWidget(product: products),
          _creator(),
          FinalPriceWidget(word: 'Мой долг', price: 100.00, button: 'Перевести')
        ],
      ),
    );
  }
}
