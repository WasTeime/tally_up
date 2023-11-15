import 'package:flutter/material.dart';

class NavigIconsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 13, right: 13, top: 810),
      padding: const EdgeInsets.only(left: 15, right: 20),
      width: 680,
      height: 60,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.shopping_cart,
            size: 30,
          ),
          Icon(
            Icons.home_rounded,
            size: 30,
          ),
          Icon(
            Icons.accessible_forward_sharp,
            size: 30,
          ),
        ],
      ),
    );
  }
}
