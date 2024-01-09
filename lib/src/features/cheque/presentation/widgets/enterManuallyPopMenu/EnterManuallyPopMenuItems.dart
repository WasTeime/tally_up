import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EnterManuallyPopMenuItems extends StatelessWidget {
  const EnterManuallyPopMenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ListTile(
            onTap: () => context.go('/chequeEnterManually/cheque'),
            leading: Image.asset(
              'assets/images/myCheque.png',
              width: 24,
              height: 24,
            ),
            title: const Text("Ввести данные чека"),
          ),
          ListTile(
            onTap: () => context.go('/chequeEnterManually/products'),
            leading: Image.asset(
              'assets/images/Cart.png',
              width: 24,
              height: 24,
            ),
            title: const Text("Ввести товары"),
          ),
        ],
      ),
    );
  }
}
