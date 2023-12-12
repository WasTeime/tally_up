import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/core/widgets/TextButtonWidget.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:tally_up/src/features/cheque_list/domain/models/ProductModel.dart';
import 'package:tally_up/src/features/cheque_list/presentation/widgets/view.dart';

class EnterProductsManuallyScreen extends StatefulWidget {
  const EnterProductsManuallyScreen({super.key});

  @override
  State<EnterProductsManuallyScreen> createState() =>
      _EnterProductsManuallyScreenState();
}

class _EnterProductsManuallyScreenState
    extends State<EnterProductsManuallyScreen> {
  final List<Product> products = [
    Product(1, "Чоколадка Милка", ValueNotifier(1), 54),
    Product(2, "CoolCola", ValueNotifier(1), 100),
    Product(3, "Негр", ValueNotifier(1), 20),
  ];

  get code => null;

  Widget _had() {
    final theme = Theme.of(context);
    return Container(
        margin: const EdgeInsets.only(right: 30, top: 35),
        width: 500,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: 30,
                color: Color(0xFF0079FF),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              'Ввести чек вучную',
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  Widget _addButton() {
    return Container(
        margin: const EdgeInsets.only(left: 165, top: 420),
        child: FloatingActionButton(
          backgroundColor: Color(0xFF0079FF),
          mini: true,
          shape: CircleBorder(),
          onPressed: () {
            setState(() {
              products.add(Product(
                0,
                "",
                ValueNotifier(0),
                0,
              ));
            });
          },
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 30,
          ),
        ));
  }

  Widget _buttonNext() {
    return Container(
      margin: const EdgeInsets.only(left: 120, top: 700),
      child: TextButtonWidget(
          () => {context.read<SignInBloc>().add(SignIn(code!))}, "Продолжить"),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color.fromARGB(255, 218, 235, 255);
    return Scaffold(
        body: Stack(
      children: [
        const BottomNavigationBarWidget(),
        _had(),
        _buttonNext(),
        Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 115, bottom: 40),
          height: 320,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 48,
                offset: Offset(4, 8),
              ),
            ],
          ),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ProductManuallyListItem(product: products[index]);
              },
              separatorBuilder: (context, index) {
                return Container(
                  color: Colors.black,
                  height: 0.5,
                );
              },
              itemCount: products.length),
        ),
        _addButton(),
      ],
    ));
  }
}
