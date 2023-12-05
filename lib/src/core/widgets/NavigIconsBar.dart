import 'package:flutter/material.dart';

class NavigIconsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 13, right: 13, top: 810),
      padding: const EdgeInsets.only(left: 15, right: 20),
      width: 680,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/myCheque.png')),
          IconButton(
              onPressed: () {}, icon: Image.asset('assets/images/home.png')),
          IconButton(
              onPressed: () {}, icon: Image.asset('assets/images/profile.png')),
        ],
      ),
    );
  }
}
