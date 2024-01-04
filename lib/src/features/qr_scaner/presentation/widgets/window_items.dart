import 'package:flutter/material.dart';

class WindowItems extends StatelessWidget {
  const WindowItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ListTile(
            onTap: () {},
            leading: Image.asset('assets/images/myCheque.png',
                width: 24, height: 24),
            title: Text("Ввести чек в ручную"),
          ),
          ListTile(
            onTap: () {},
            leading:
                Image.asset('assets/images/Cart.png', width: 24, height: 24),
            title: Text("Ввести товары в ручную"),
          ),
        ],
      ),
    );
  }
}
